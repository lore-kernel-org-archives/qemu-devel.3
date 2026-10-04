Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62298CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDQ4R-00033d-BQ; Sun, 04 Oct 2026 13:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1xDQ4N-00031B-Ax
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 13:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1xDQ4L-0006kf-9Z
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 13:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791135131;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CQ25D3rmkVESunmbdzD9e9ZxJxcmA6/TYhSr5GTnZso=;
 b=N/IP+rx+UMJBCkD/UYAso3EZueQH3KniFNYkPmv9FdN1wJmDWXKDXZ4ooCl1gcvVX9n6E9
 UKkV5b/+bKEUsUTNcggO64VnTpSx3pDayn2dBI234MmtEU49K8CJC643WU8cnu0My0s9Fq
 1N5mfZ4wl7FGzMwGzyunZ6edDKk/b8Y=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-7cD_CzVCMEicSXv17qOHcw-1; Sun, 04 Oct 2026 13:32:10 -0400
X-MC-Unique: 7cD_CzVCMEicSXv17qOHcw-1
X-Mimecast-MFC-AGG-ID: 7cD_CzVCMEicSXv17qOHcw_1791135129
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso1241193c88.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791135129; x=1791739929; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CQ25D3rmkVESunmbdzD9e9ZxJxcmA6/TYhSr5GTnZso=;
 b=MCHvzWoEQqhN0iV/ogqRMNxY4yPULLaWvFkKHK0Wmn4yc1vKGaVf4gSMTTMAbWw1pK
 BLMbgoOq+K5OJBShF2MW+4mYIF4fXT3q/7pS9+NWF1hs99xdaiH9p1SomR90/ACAgdAt
 XxY+IrD635i1OCDDZQrlxDZf8I54YRMUUvlzjxkBk1XgGp40VkPQOuUegY/eDr2nruQd
 +S3RrFA2yP4tNe6cn9aiTiiky4758iA1cjkCMxJgb0aCMINM+HUdlEL2ck+FuWbZ16YT
 d1mEdATi8d3OhmmmNXwYsJHLtQlMkZI/+7cQzwMQNBWMTr5RYImZL+eDr4uQUSSORJWo
 PVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791135129; x=1791739929;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CQ25D3rmkVESunmbdzD9e9ZxJxcmA6/TYhSr5GTnZso=;
 b=agDYccUbKW2Get+sgAx7B65fng9AcDWp0hrL6RhTFJRofEcWCaF1p+ZTk+BhU5iq23
 B2Ohamqk1xk8YLHPrHSpYQnRvwwsm8QGnExNDLnldNQp9Zvl8U4xfMUxABymqPVH5phX
 bJ5bjKz/JBhK5YDhHLx5sWACNmxyssHnB+SGrJx6A/+8JyCKHY98YKoYMyUy0KDX/6RU
 yDAyooRZL4MtsdhCTQ+mh33E7L2zcf32vtdSh4mq8TnpBzPLfoQjwyrxFKMRMoDvwHFA
 BsLAOt2J9QJKCUbeO+xJTjLDJEQ3fJ+FCV4Y4HpbaXBCnJc7seaTTa5Qgr2/O9nKVWMN
 B46g==
X-Gm-Message-State: AFuF++lMh/G58UeAVZpt2G+YLVdhAovZ+WJsnjGprCXAlJHjEVXQW07P
 /sUj+whT+yD6RwCB6rIDbC58p/2LFdQIroeBsRpgQxADI1kP6cSqPkzJVNyZfSxhExdiVP1+b6S
 OgGXMwyEUEHW2SU9B7bULhaiT1XTyHQMkTnwALFOySRq7bWhCOnaVsjAI
X-Gm-Gg: AYBFou2yWU1S4v3MK90otAzU3bVPilF9ttcFLOAArsLNdlOM/XFSOANVTKvZxBCiv5q
 MoN7WwnF4BEZXD5/+KlwVl2HvQ8Ov/ltATd6FXcRK8Eid7QbtVXbkosYI6+wCWjTysIUj1PI586
 Ie8q8S+MDPdQyh52WjbsNsFB4FRunZOZbZJsgVIMIFWypZXRUpPDau6C87ttRf6dhPT2XiFo8BZ
 vugbZX0jfZ5HYHkEI8OfWbAEJ/hQmaTpLZpmqAfIF1P0vsAoDFz+HmGukYJuOCYTGwrLkV34Jis
 HLlv5XOpTkzyOPmXbeZmhZhzE+JM4zDDA5S4gfqvFvdElyi7icflfIeEz4cjNTB1GgY=
X-Received: by 2002:a05:701b:4289:20b0:14b:2397:d8f1 with SMTP id
 a92af1059eb24-14f5bff48a1mr10987354c88.9.1791135128819; 
 Sun, 04 Oct 2026 10:32:08 -0700 (PDT)
X-Received: by 2002:a05:701b:4289:20b0:14b:2397:d8f1 with SMTP id
 a92af1059eb24-14f5bff48a1mr10987321c88.9.1791135128255; 
 Sun, 04 Oct 2026 10:32:08 -0700 (PDT)
Received: from fedora ([49.47.193.161]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fcc8a5afsm13666831c88.12.2026.10.04.10.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 10:32:07 -0700 (PDT)
Date: Sun, 4 Oct 2026 23:02:02 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Subject: Re: [PATCH v3 08/10] hw/tpm: crb: Implement tpm_ppi_uninit and use
 it in tpm_crb_unrealize
Message-ID: <asKNkkbmTbNDWKlu@fedora>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
 <20261002142516.2063735-9-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002142516.2063735-9-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 02, 2026 at 10:25:14AM -0400, Stefan Berger wrote:
> Implement tpm_ppi_uninit and use it for proper teardown of the PPI in
> tpm_crb_unrealize.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_crb.c |  3 +++
>  hw/tpm/tpm_ppi.c | 10 ++++++++++
>  hw/tpm/tpm_ppi.h | 10 ++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index cd46b2e888..5c50a79936 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -16,6 +16,7 @@
>  
>  #include "qemu/osdep.h"
>  
> +#include "qemu/memalign.h"
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -527,6 +528,8 @@ static void tpm_crb_unrealize(DeviceState *dev)
>      if (s->migration_blocker) {
>          migrate_del_blocker(&s->migration_blocker);
>      }
> +
> +    tpm_ppi_uninit(&s->ppi, get_system_memory(), OBJECT(s));
>  }
>  
>  static void tpm_crb_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> index f0c34291dc..35baa083f2 100644
> --- a/hw/tpm/tpm_ppi.c
> +++ b/hw/tpm/tpm_ppi.c
> @@ -57,3 +57,13 @@ void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
>  
>      memory_region_add_subregion(m, addr, &tpmppi->ram);
>  }
> +
> +void tpm_ppi_uninit(TPMPPI *tpmppi, MemoryRegion *m, Object *obj)
> +{
> +    memory_region_del_subregion(m, &tpmppi->ram);
> +
> +    vmstate_unregister_ram(&tpmppi->ram, DEVICE(obj));
> +
> +    qemu_vfree(tpmppi->buf);
> +    tpmppi->buf = NULL;
> +}
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> index 88f316ee95..c173889033 100644
> --- a/hw/tpm/tpm_ppi.h
> +++ b/hw/tpm/tpm_ppi.h
> @@ -32,6 +32,16 @@ typedef struct TPMPPI {
>  void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
>                    hwaddr addr, Object *obj);
>  
> +/**
> + * tpm_ppi_uninit:
> + * @tpmppi: a TPMPPI
> + * @m: the address-space / MemoryRegion to use
> + * @obj: the owner object
> + *
> + * Function to unregister the TPM PPI region.
> + */
> +void tpm_ppi_uninit(TPMPPI *tpmppi, MemoryRegion *m, Object *obj);
> +
>  /**
>   * tpm_ppi_reset:
>   * @tpmppi: a TPMPPI
> -- 
> 2.55.0
> 

Reviewed-by: Arun Menon <armenon@redhat.com>


