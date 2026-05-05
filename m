Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3033FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK94j-00029U-KM; Tue, 05 May 2026 02:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wK94d-00027w-7i
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wK94b-0001vd-TL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777961761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgsIdq7g2ZIrMRRBdQi24PeWu1d00wa1MLN6H7P28bA=;
 b=A3nOMrgGQuMgvd+0khcAXSqMbs7CDwgfPuvLaX/358EK4IEnlhOLio/HacblqoZK++FTo9
 xVO7cmzxWbK3miVKHEYe7RAQPC6eLoR0l58wwAipZ4X4iNfoOmrFNOMce34wnrhjGc7sY/
 xFmmr82pgegWXBYAachPMd/mRaTMsB0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-lEn96rBINcKpfD52mrF8zA-1; Tue,
 05 May 2026 02:15:57 -0400
X-MC-Unique: lEn96rBINcKpfD52mrF8zA-1
X-Mimecast-MFC-AGG-ID: lEn96rBINcKpfD52mrF8zA_1777961756
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A153718004A9; Tue,  5 May 2026 06:15:55 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86DBF1800480; Tue,  5 May 2026 06:15:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 5/6] test/qtest: Add test for tpm crb chunking
From: marcandre.lureau@redhat.com
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com, 
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260504174234.13556-6-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
 <20260504174234.13556-6-armenon@redhat.com>
Date: Tue, 05 May 2026 10:15:40 +0400
Message-Id: <177796174023.65777.11175485550532599151.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=612;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e8uud5Zb0D/1acIqbFgbMC5NLwNKyPwex2D3Zzb7vrw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+YsO+0LoocgDz9oRr1MnvbS7WXnWGW37OokXs
 rcEvz32Sr6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafmLDgAKCRDa6OEJdZac
 5cW2D/46o1oMTUSZBRsjcalv1Egagm3NuyPU7eLp7bNxpH58XhQuoVgpk4yMUCYyTLPF6BCuRuS
 TscMhEx69Ztuz3muyMJZamqOj19vmhm8m13zEWpYzF3j55KProFlqgR5bvSBnPfPfhZrMRckWQJ
 zmfyOI+K1bFsWQKd9p0AXlKpEKRIZ4H3FucJThMD+V4RBTmkXWbTIWVMd6z+Ve+ZAXNsHg34BIR
 W00YrZuwzoicNPVrOZZbTxSmBHGQJTzFdnbcKWBWAzUjJtya6r75c6ACDzkqxiTh0lH0BXtB3WI
 BiVxgbY3rQ0w+57LOfxAISSbJF8KQljAQkV/K9m/BTKReNoBJVgdv3oVySoszur/NFATIicONKc
 lWcjCvqjuERWvO8dsO3E7UCJOKByhijdrgz5OzQGfcq4mmJwwtcgJ1ARn500wfOINd6rh+KS9ov
 C74LCHnI45k7SIOQs7QCcdHdev8nSu03RjHk5ODmgGMCkT7A+TMmV05+zKUDQDhSujngYVh9/Lj
 blXzzdn+9i/DakwhkmdSm4iyuhx1XU2s12nOjmC7Si8nt5myO2Q3aMUGw/cThOdTPYdA5tTM2BQ
 T56wcjcmkLVCnquUaZOOE5/Hga/tETFKzWMUihkhdVkEaJDBqze28pUafTW4EobcjsDm8lns8a1
 6YnV5sFpMez5gfw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 04 May 2026 23:12:33 +0530, Arun Menon <armenon@redhat.com> wrote:
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 2cb2dd47961..744592763f6 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -31,24 +59,76 @@ void tpm_util_crb_transfer(QTestState *s,
> [ ... skip 64 lines ... ]
> +    /*
> +     * Read response in chunks
> +     */
> +
> +    unsigned char header[10];
> +    uint32_t actual_response_size = 0;

Per QEMU coding style, move the declarations at the top of the function.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


