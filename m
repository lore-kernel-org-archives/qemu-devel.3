Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AA6C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bO-0001MQ-Je; Wed, 12 Aug 2026 10:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bM-0001DA-Er
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bL-0003Bv-3Y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HBh5GraFEML+ufb4FsNN7bUbTQHUsbYA9AFHunk9ac=;
 b=blZXafPopqHkzumwoSUq2trlDas28wjEsDaPEomnlJ7wqRtwwUoGApOw6WcB7A2QPV3Kcm
 4HEfwwqmtN/NO2U2zhfLvT0V/uU8Bn5TpjUHuPy8IM9o9i2KiRRj9DWSysL22viKgPEfUn
 to8Hi5/6HNPTASFxUZ0qp4J67tadG1o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-JdEVuza1Owy8b3gg4Uay6A-1; Wed,
 12 Aug 2026 10:06:35 -0400
X-MC-Unique: JdEVuza1Owy8b3gg4Uay6A-1
X-Mimecast-MFC-AGG-ID: JdEVuza1Owy8b3gg4Uay6A_1786543594
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6AA11800BC0; Wed, 12 Aug 2026 14:06:33 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1385426; Wed, 12 Aug 2026 14:06:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 13/16] system/dirtylimit: Extract HMP code to
 dirtylimit-hmp-cmds.c
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Hyman Huang <infra.ai.cloud@bitdeer.com>
In-Reply-To: <20260812131147.83188-14-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-14-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354343.2071945.559051598187488155.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=222;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VxTDgo5G/m/UcmZm1qPcJWIBb3ARsq6N8Xdfrp/Udqk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH27baZ+d0BTTIPwinCemfkhhdc+zagoJVcjw
 3F92jC1AyiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9uwAKCRDa6OEJdZac
 5XuzEACelmXHFmI/HyuauO/WKgIbSsuIDQfPflMtQnKMwyPZhBGEhdAyUXwGXFHStM2GyLlJXA0
 WoyujNhdvt0l5oA3Tw16bBetv/zA/q72Mc1mAIRlIKsumLQba6TLr5XmlAjRBBvTAnAmk/fDRPG
 2A/qjkF6T52gLgm847CHh9wJCIZ1J9beVd8YK0wqlyElI4JvhMlANuveUlfM7mpBm7mYp6VzmPa
 hqfngwRoClCUHleJq7gLaOPPzg+KbiyoN7bbmT88M+n2n/7H2KyQksZSBJOcYCqd8abf3DCksGD
 5GgMVAwyT4jQEgTIHqdfW1oU51Za69BQO5leLkIv5yxZDqGsYxMKVbUlKGFU4/KGpcUgWxGN7aj
 nJWzJ/Bd6O9MQLpKfQ+NrDYJfbLmqDr/CO6WCWf9w8NjtrMFhLXksuYcznTiQt6kN49gN2+FSPt
 NEdbmkoIFdaJn9Pp6O58iW0uFZPsZZozTKe98x5V7A3d3LAmARHFNHTJx+4bO+wtM44tcLRNcTj
 tdGeMQisD9u1QCVkt+n4A2+rhBADCSaFeOdckixwOHvRLriAJXeKCf1Jx1plFG82xfq+3PHCC1t
 LuzTusu8pqbjJI3iXQpW9oGtI2U4E2CaNYpJpGYa6QRjOgghFT87SngpFEsPJlTglIfzzmTxPCX
 9tLrhvip+LpXc7w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 12 Aug 2026 15:11:44 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> 


Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


