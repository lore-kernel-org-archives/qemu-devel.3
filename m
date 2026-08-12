Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDD0C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bZ-0001oi-Py; Wed, 12 Aug 2026 10:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bX-0001la-Th
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bW-0003EP-L2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9q70EIwQ3JrX/QtueH/MhKmrPpNBR6HD487HLLqF+CI=;
 b=IGcWrWHrU5aIpzSotBpP8SD+Opt0z1qK4pWth2NXJnjdekAmm7YaBnqDx/TtcRbJTUl7/8
 my3ISEr9XXewqYhEQepAMG2kBpIvxqejhD3XswmbL0Oe3b7j3hHNSjEfG2kMxvicJ/qiWJ
 hXapy3yjsw6mmNqjD4S9ZyZwg4q5pGs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-qdlvWEICOUqnXfK5pHtOZg-1; Wed,
 12 Aug 2026 10:06:46 -0400
X-MC-Unique: qdlvWEICOUqnXfK5pHtOZg-1
X-Mimecast-MFC-AGG-ID: qdlvWEICOUqnXfK5pHtOZg_1786543605
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77555195607A; Wed, 12 Aug 2026 14:06:45 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65FEC180034F; Wed, 12 Aug 2026 14:06:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 16/16] system: Move runstate-related code from
 cpus.c to runstate.c
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260812131147.83188-17-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-17-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354345.2071945.1111568371096940280.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=662;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SUUXdBLzqj3mwYb1R0ysbinid/9PuwEfdi6XnZo6pCI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH27991/ocF/lzw9p5DrmGJVePNKmIgZK/NcL
 GaF13bZIseJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9uwAKCRDa6OEJdZac
 5T6yD/0QZri5Kxken8w+jl28UXZfGM22xIExhbFeGzqvKSapF8bM7hFkRgtmukVxK+lCJ28+NLY
 of6lERPl370JGKnagMw8Fom8G5LvhIJreZx6auHnHUCiXYhvM3JO5p5oS0ueuBr/g2kqG4GOi5p
 FHqGfl/zANVisWtyCWulaeHymw3Z0aM0hv0IHFN+p8ch37+DQFg5wDKQnzr87+WLUxNT1JQFhZh
 IIFiS8mDe9jc2JJ8srWjLxsqXJ+WdA5WG/zo4af5bncOFZzHv7guneJTNWaGb2mmErckEeCeowa
 /R0oxP669yR2HoRGrFEH7mkMYJsDlz1eNYKSxPnnMaRAkECw1Zd9odkGf5HO2+bdCyMVKVmpUTI
 ZTib+JTYBmj4OnP1URhj4zEPbyok2ixN6btyGz/irttwTzuoyFqEQ6qxks68Wyunujod+dmiFN0
 aG+aii/0rH0aJsk/2IPiO0dgYvOKEVM1IZe/sTjGDlzG1eezx0JyczneY/OzPE1pF3DKoHbYPwa
 o8pvk6IenDfp0kxNdapbutDPtLbbDngDLeh7yO5SC+KHy9kBKDL11729mPy/WpJmMGmTbvgwVvu
 GaCbJfZOhkl8JHMuLA3igYg4Mn3Pd4t9g2qPDqzr5HFs8HgSIThZfNFRDUhC4egm20OBTMdF6L0
 XYFe3HzIYcoTWPQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:47 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Keep cpus.c focused on vCPUs handling, move code related to
> VM state to runstate.c where similar code lives.
> 
> Fix few checkpatch.pl warnings:
> 
>   WARNING: Block comments use a leading /* on a separate line
>   WARNING: Block comments use * on subsequent lines
>   #327: FILE: system/runstate.c:541:
>   +/* does a state transition even if the VM is already stopped,
>   +   current state is forgotten forever */
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


