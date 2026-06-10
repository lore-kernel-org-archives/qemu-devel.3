Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B21FCD98CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQH6-0004Rl-B7; Wed, 10 Jun 2026 17:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGW-0003t7-BW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGU-0006c1-9s
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JljKq2Cyjzbrdt7KvqbnLXw8EvWjqKgw8dKdc8HgjZ0=;
 b=MQqbim+Akm1C03XM89uba91GLoEQw0stq1oODJtG6qRR/NRDHczmiglWcIVlxeBCyfk7dT
 W+S+bCNWCBNOUeTee670a0QphxnL9A7CiUHNK94SjbeBUFHFIZwBdyS8LgEc9mMpH6ATq/
 8uUcGWY3wl3Wa9MhUpya+NKYsNvcriU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-LecnEZlVMRCbM806zz3g0Q-1; Wed,
 10 Jun 2026 17:15:06 -0400
X-MC-Unique: LecnEZlVMRCbM806zz3g0Q-1
X-Mimecast-MFC-AGG-ID: LecnEZlVMRCbM806zz3g0Q_1781126105
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A0BF1964CEA; Wed, 10 Jun 2026 21:15:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFEB419541B0; Wed, 10 Jun 2026 21:15:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 14/35] monitor: use class method for I/O thread request
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-15-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-15-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600350.209622.246884958677388828.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=348;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O26+ThE4QT2WI1WUZb6K5gioeQPzxanIeYH6b1mOVUM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOAss58eUCrHYZc42TtZroPFV7lBjWEV+qk1
 1Zf831cgK6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTgQAKCRDa6OEJdZac
 5QChD/9mSiNB7g/NRYTeTYvmYyPN5xNdz8QE37vnMzsRryHwGnjCCBwwYI0DYNMlyQELGbB/bMD
 hsK0WSJJQ1sfGQBn5T/HSIvGXe/NJGXNTCSuOB1SZW/GtZSwQ4LKHPSTrwsBZpyh1qRlEyGiVMo
 7H8fMOVN93yFKaFLO173KoDOSyjIeLZuDgT2Iw4aasYsmC/75A2MdyffJblbHXSq2HPg05aFsPX
 pHcZ+q3lgVvpye27J8jtr6VVh6r0G3vMFwsDgg9gKYdQFntz+1wRq7smB2YgzlSQ4SGU1BrhQB5
 I6O7/71oLy9i7IGZoEf7c+40v6G9PTGiN/Vj6T3hbljT906MqVqjDPWz3leh52LYDWRkmQK/IAi
 QJSRm0N15I9A0hxz66X7cLF5xQMqjnm4579VtexxniQo1ff6QojQCM3APD2LxLvAPKtg8WTHIHa
 +N5afFTBQQh8dmzhhxBR3LOkAb4uI+aWxi+BKO3VxJKzWbiwi7dBldHLExusEXRrEq5opGz54Bd
 IFjAuLmj3IunQU/PNPoWt7zr7CWDQ7iPU+eIOzYrro3lXg6TvW6s/j8VQyTH/f+r7JnGPihIFe/
 yEf/3xBlEMtHTH3nicbp28HM8c+I3E3Tk9kBr/u8fDU8pE1wurq5q2cQDB/dE8uAV/buM0jiOqh
 wYYat+G/htcdPtw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 10 Jun 2026 13:33:54 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Introducing a virtual "requires_iothread" method allows the code to
> automatically initialize the I/O thread during object completion.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


