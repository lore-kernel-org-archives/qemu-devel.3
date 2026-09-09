Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66610C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OmH-000484-Sy; Wed, 09 Sep 2026 16:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmG-00047h-3L
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmE-0006vJ-GR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eA8a2yxPiZlNDeeWvzu6tJxDmu5mrCXOp9NoS+lQxMk=;
 b=YEtJyYmJTzXpb1Q7NsNIvkNeZbYQ8xzkNwJv0eLqUiGuhRjVfxnts/B6ki6Zg59URmvqao
 xYjBtsNc9UvDQN1vb1PboUJKg5oY4lAYJRHMlAUFYCdRCfd+2WLN1MNFVGLjKIX/2+1x6K
 Bv2E7f0L6VYmde0e6X2tVkXDFT08aTI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-AMisjOLNPEK2P_KMKWTg7g-1; Wed,
 09 Sep 2026 16:20:12 -0400
X-MC-Unique: AMisjOLNPEK2P_KMKWTg7g-1
X-Mimecast-MFC-AGG-ID: AMisjOLNPEK2P_KMKWTg7g_1788985211
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 853CE18005AA; Wed,  9 Sep 2026 20:20:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77C6E18002B1; Wed,  9 Sep 2026 20:20:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 10/14] hw/core: report security status in
 query-machines
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260909175656.1572689-11-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-11-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517059.2613908.112384748355364638.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DtSW8m5wnedsAL2t9TD4xlL2SFGNskSBzspKc3bIj+w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9WSIewCyXYJsWuwMu0jZTSaReWLjJo09NfN
 9clwMZXvJaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VgAKCRDa6OEJdZac
 5VftD/kBnFBgUYaDgvQuOjz+wyVWsJ+9qPfirDPi1Oqn28oScyzDdvp+ic8XFJ968kw4LKH8wVP
 y7QVDOVLsI2jcAjddCcQCcjRhY3nnGgTtVSroXyagkFYGmhNmaQ4MOAj7jn7SQFuCgBhq8H3hSD
 n0ExNwUhB/i2y9c6GUKJG/glKl8z3iZhHlpXVkZjCfV+bQr/rszOyrmns0UALpBnEwQqthynaD8
 yurheJojuogjMki3wh6Gbn3+q1kvL+2hMQLOJUBPLEmj2oUnAOFaNfJpeITNHQ1Bg9cQhw26N3N
 1Ghthox/1TwrLy19X2snZcbS+VRpaZzcAGoHufA+jsLMVQeCbnuc93U1UufLpnnpT/6rgSddHmv
 eZJelxFKiaFHvMcq5jT1baibpj2Yx39GG5E2lZRpipEx76NcfyL8oq0Rtrn3maPsQV8izhqxnKf
 pVlbBZrmLToMf7aDq6bdAN+TtglWkd0Gs7EM1mg8Lh+3texhQZcEG8n5AfLWl2sgk51fqkzuinp
 E1s2RHtUTESrgcF6cXkw+/EqScSUCW7L9Gi/j6vJNqfeApLEO+TqNLjvLFImSgev27Rb/KaQbvG
 fnXU2yDyqiAxb+nB2OHMjnXmM4WRq/po1Dcdi/0tk9c8l3CiOnFhi+ymy+97+wB5InTM0f8Ls8t
 rOkTgbYBkyYGpcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260909175656.1572689-11-berrange@redhat.com>
>
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 543dd3201b5a..9c08b17510a3 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -127,6 +127,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
>          if (mc->default_ram_id) {
>              info->default_ram_id = g_strdup(mc->default_ram_id);
>          }
> +        info->secure = object_class_is_secure(OBJECT_CLASS(mc));
>  
>          if (compat_props && mc->compat_props) {
>              int i;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 2d63c1bac3b4..942db9a52ba7 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -196,6 +196,11 @@
>  #     present when `query-machines` argument @compat-props is true.
>  #     (since 9.1)
>  #
> +# @secure: If true, the machine is declared to provide a security
> +#     boundary from the guest; if false the machine is either
> +#     not providing a security boundary, or its status is undefined.
> +#     (since 11.1)

(since 11.2)

> +#
>  # Features:
>  #
>  # @unstable: Member @compat-props is experimental.
> @@ -209,7 +214,8 @@
>              'deprecated': 'bool', '*default-cpu-type': 'str',
>              '*default-ram-id': 'str', 'acpi': 'bool',
>              '*compat-props': { 'type': ['CompatProperty'],
> -                               'features': ['unstable'] } } }
> +                               'features': ['unstable'] },
> +            'secure': 'bool' } }
>  
>  ##
>  # @query-machines:

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


