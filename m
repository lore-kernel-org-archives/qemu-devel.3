Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41DEC98307
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KfX-0004Xm-UI; Wed, 23 Sep 2026 06:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfI-0004VO-IZ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9Kf9-0002Ka-A3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn+Z8YRnUMYZfp76Gs9Pi2qRErlj91PTtObbshez4KE=;
 b=NXUcBDCTTmJkqQg7NwoTjWzIoJmdr2U8E6ur5P/28oSEUsdteOVr1TM2R3LSRnhAggW5ow
 NyFVYsS6wXo1DoJsY6V12BW2uL+aIAiTrLqQhWS967AeR4PoZknIt56q7YG9+cVr/RRojS
 zrpzi8jPi1NuzcyFyKBzHZrEyT4vUWs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-KawlLCo5O7i6cEw4D8-PyQ-1; Wed,
 23 Sep 2026 06:56:58 -0400
X-MC-Unique: KawlLCo5O7i6cEw4D8-PyQ-1
X-Mimecast-MFC-AGG-ID: KawlLCo5O7i6cEw4D8-PyQ_1790161015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 953D91801310; Wed, 23 Sep 2026 10:56:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5657B1800603; Wed, 23 Sep 2026 10:56:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/9] machine: allow -M name to differ from QOM type
From: marcandre.lureau@redhat.com
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Stafford Horne <shorne@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
In-Reply-To: <20260922215533.641-2-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-2-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100537.1396491.4846812267578164568.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JvBEFlDyT/Gw17oCZYFjUrc5CNqLyJSfuaFPRSQqseQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7Bw16tQ1WhXZOTGvE7HBcXlKPbUqOOdtIlA8
 BAfl426OEiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcAAKCRDa6OEJdZac
 5fMLD/wKq8wmnDYnpEPL/3wLIxbWjyXED1f/YxTnuiH8LSpo17DX1eK40lMPgMEWUVOYMb9401q
 OU6+xbGs2uyUd8FyCPnYQFvJzwTqUT9u8uFOIIx1ZCLUO/OqB+3wFhU/KmkJPOphWcBaGf/O/JX
 EN5xodGifP7e7SQyUyciGLtU6G3RlHkZ3mNCHrGkTgW6N+p5ueO2GGLcoPzEywbYXMilIH2xgET
 W9IipG5goEiBAxAhIidVOqSIlZ46FD57nXf/6YGyRsUdNCTcfGrqrrlgg0H5rxRDAKTy2/3WU1h
 MsqS/0mpQalsDgnY+7ThEyzc2HVOkfZIqQru1dhF6jE5Gfhbr0SkEVcVUc9UeugERs4GFq9GJXl
 jfqfsO0+/ZPJoEP2pjqwqZCubMZ3/VdOe4ZchSV075mFTBnOzCAwnuR0vOtQ+wi9qABwWZsY91f
 y7/nW9HyjTCluPxnn5Ytieyyv6bUSxLth0b0E+kXiYzGw5uyXhOEE9BVmCGBcWnkn7q2/zMQXI7
 worJ2UwIca7sUe2k30UI70s48BpyoCxEvoLNG3wAzluLD5CKRgESRPYt0E/30Ie/IaEknXALUNv
 eABdb8NnkuFXNLZ46ZPJ/BpTDnu5DfLVWgSCwrF3C2YUezZXDhvJnqJWUSLAcI47ozZOi507xsG
 kOy1FIjFPT7xFlA==
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

> - Add machine_class_set_name() so boards can keep a stable -M name
>   when the QOM type is uniquified. machine_class_base_init still
>   defaults the name to the QOM type without -machine.
> - Document that MachineClass::name is the -M name, not the QOM type.
> - Sort -M help by MachineClass::name so order matches the printed names
>   when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260922215533.641-2-luoyonggang@gmail.com>
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 92f7be52a13f..6b933f2302d5 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1215,6 +1215,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>          "Memory size configuration");
>  }
>  
> +void machine_class_set_name(MachineClass *mc, const char *name)
> +{
> +    g_free(mc->name);
> +    mc->name = g_strdup(name);
> +}
> +
>  static void machine_class_base_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 3b86724cf007..851140ad0520 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -36,6 +36,16 @@ const char *machine_default_cpu_type(const MachineState *ms);
>   * @mc: Machine class
>   */
>  const char *machine_class_default_cpu_type(MachineClass *mc);
> +/**
> + * machine_class_set_name: Set the -M name when it differs from the QOM type
> + * @mc: Machine class
> + * @name: Name used by -M lookup, help, and migration
> + *
> + * machine_class_base_init sets MachineClass::name from the QOM type with
> + * the -machine suffix removed. Call this from board class_init when the
> + * CLI name must stay stable after the QOM type is uniquified.
> + */
> +void machine_class_set_name(MachineClass *mc, const char *name);

add machine_class_set_name() to the comment example around line 484:

Add after the existing mc->desc line in the example:
 *          machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \

And update the example's type name from "virt" to show a prefixed name like
"arm-virt" so it matches the real usage pattern.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


