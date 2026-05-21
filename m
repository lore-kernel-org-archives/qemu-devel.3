Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4094ACD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9qC-0005Bp-Bb; Thu, 21 May 2026 16:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wQ9q9-0005BE-1N
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wQ9q6-0003hM-Uf
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779394673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsCL0r7r5uVznA4axQ+PIrE31dTKcqqwgJyhUkVMNQ0=;
 b=Tqy/G1ewvCK1evbXM5EGUSTgKuGgCPzB5dawozvu+mFMe0YeOy/T9YXbzqfTWvuayYHbiq
 6Ld3dDKYwnL1FFwjAj+hfpRUiiKnxdUHQvIcg3OVUfF+qB6ZhMak8EoHzcK6UUPVBJoKrC
 SLE6H0IR/90nUK/2PVrtqobhtaNITRQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ZNi1Ws0sOfGv9QbPVFstdg-1; Thu, 21 May 2026 16:17:51 -0400
X-MC-Unique: ZNi1Ws0sOfGv9QbPVFstdg-1
X-Mimecast-MFC-AGG-ID: ZNi1Ws0sOfGv9QbPVFstdg_1779394670
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b4654f9bb6so63832525ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779394670; x=1779999470; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FsCL0r7r5uVznA4axQ+PIrE31dTKcqqwgJyhUkVMNQ0=;
 b=lNcMbKmFBPK0YE0ECJTiBIGNcnzQcNzeTBsrjjdxaGSBgDt6HUTQZXKRrxO45EGowY
 Ly2r6w1M4N6kGdOOtzFAtJ2D6KaXZWftNWTV/9BLcobxmdhpToyZLLOZPnY2HQ0M6mLc
 k3vii089Z2Sox+MyR02vPpNU2xUrEGkkP7fWZ/KnQ/UxbL5g/tMbWWI0/J0BuFeeWNU2
 0vGIFPi91cNeM3g3IAuZK1Ym003uo2AP1nImsDpJ7zg7qWIK1RpFOJ9UQYQ+DyHaQir+
 IfJUGK0cnA9qdUngGnH9okXsYSMgRWO6eG+yYBmuuKaJe1nWqcFVmETDPWuxSAcPlfsS
 Ruhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779394670; x=1779999470;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FsCL0r7r5uVznA4axQ+PIrE31dTKcqqwgJyhUkVMNQ0=;
 b=BwnEnVKuR8sWvIEOD84e5xV+wEoh7AHs0RHyZTwi4AvMc1OpnrEKq+N3OePJVmzboV
 U9T+S007sH/taSvKYylNFHdIbDKfYBhTd6yWi/HqkyCO33sN6vspQsV4YxKUwyUmWQK6
 9rDc0ya189tLPmntHyoqn9Kuw5KO0wDXTGcdUCsJFnYEb68RHzpSpdusYY9c+4atFOG8
 62Ldfwka32p0e2VBG2tKG5Y8GUk66w5SiG4/ZQKhoiS+uYJWclzPGoC2C93e+vzTcquE
 Guh1nxV8q8sfwpmPV6yCpVee4e5Lihn1TBq5+vJdxsm6/zFsJ1o6+M70hTXISR8Kwor0
 8zLg==
X-Gm-Message-State: AOJu0YxKpxFGtV9tfjrRgtDXvEkPuoZS22C7lgZQBLtexyxTYbakllRO
 CECFGqPhzzDt2aB+h7puGckKGKiHoQMgEs6zJUKO0wZ1VjDChnIPoH1PwlEwEIw26fMrLoaYivK
 iCz3W8bS5hkCADNofkd3TAwVhWBV8PDiD1JKdGZ2mCia1Vv5cTbQK5tPa
X-Gm-Gg: Acq92OHG7G9XZ+mwNPJjW7eJlZB8kc+PF0x9RwMZsfgucwtqfZHAtwBh/9bFtNtrGGY
 Hzhficl6Iwh3jWtwcBuuoaXGK9i+2N+y5k2uEMEgkpX/HqPdOLEsZ11eAbSvKp75cxBbS8OUzGg
 qmiC86y2rhgztG71jp7D4GcQ50im95OEMHwz691F0kUNyHAjjWRJFWL92W2jcayNtz0M9ggmMF5
 e23SF8ucYUrS7+xH/iJQbQZa/zxTa7n1eyLhCNUUz78DNw4TP5pstBnUMF4GuBVQE5WkXLRqAks
 IFoHFIYPLRmzgNhvnTui8jJfVG7VIZ8auW6ERcqjVg31CH5Gb9oM7lVI5X8dGsxP9dXwFM61IRy
 yXEWEmSHiw6s=
X-Received: by 2002:a17:903:41d2:b0:2ae:4a4e:1e25 with SMTP id
 d9443c01a7336-2beb07b77f6mr3733915ad.25.1779394670355; 
 Thu, 21 May 2026 13:17:50 -0700 (PDT)
X-Received: by 2002:a17:903:41d2:b0:2ae:4a4e:1e25 with SMTP id
 d9443c01a7336-2beb07b77f6mr3733625ad.25.1779394669816; 
 Thu, 21 May 2026 13:17:49 -0700 (PDT)
Received: from fedora ([49.36.106.50]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb1403b35sm744385ad.79.2026.05.21.13.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 13:17:49 -0700 (PDT)
Date: Fri, 22 May 2026 01:47:44 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH v3 18/24] hw/tpm: free PPI buffer on finalization
Message-ID: <ag9oaNePe_-iS35W@fedora>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-18-3f20c3a029a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516-qom-tests-v3-18-3f20c3a029a7@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi,

On Sat, May 16, 2026 at 11:59:17AM +0400, Marc-André Lureau wrote:
> The PPI buffer is allocated with qemu_memalign() in instance_init but
> never freed when the device is destroyed.
> 
> Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/tpm/tpm_tis_sysbus.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 6bec30c36fc..3984228c42f 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -150,11 +150,20 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  }
>  
> +static void tpm_tis_sysbus_finalize(Object *obj)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
> +    TPMState *s = &sbdev->state;
> +
> +    qemu_vfree(s->ppi.buf);
> +}
> +
>  static const TypeInfo tpm_tis_sysbus_info = {
>      .name = TYPE_TPM_TIS_SYSBUS,
>      .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
>      .instance_size = sizeof(TPMStateSysBus),
>      .instance_init = tpm_tis_sysbus_initfn,
> +    .instance_init = tpm_tis_sysbus_finalize,

shouldn't this be .instance_finalize ?

>      .class_init  = tpm_tis_sysbus_class_init,
>      .interfaces = (const InterfaceInfo[]) {
>          { TYPE_TPM_IF },
> 
> -- 
> 2.54.0
> 
>

Regards,
Arun Menon


