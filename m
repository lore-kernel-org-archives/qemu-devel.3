Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B92FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDnU-0002ol-Rz; Wed, 27 May 2026 08:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSDnS-0002nw-ME
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSDnQ-0006Kv-VK
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779886540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOYLvELL4pA+7Ly7GPZaewUIz4EzT8B65S7XSvB4MuA=;
 b=ZsxorP3lkXQwt9fF0/Rzy4WatK3DonWo3WqIN4uuXbZYvv9kjTXE+OyZgcB5hI0YJ6hmEe
 MWBEsaZxfjnxwHDtCLBXeQvyYiXxrktiyoe4Y15ezxuV9kWl6bC/fVEn4DM0b2c4BoFwoJ
 indL9X+TFMo9J03z/dKVY3fQJ8fzHxc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-dq6Jloq-PlW7LYi_A7ZIDw-1; Wed, 27 May 2026 08:55:37 -0400
X-MC-Unique: dq6Jloq-PlW7LYi_A7ZIDw-1
X-Mimecast-MFC-AGG-ID: dq6Jloq-PlW7LYi_A7ZIDw_1779886536
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fd396daedso64662745e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779886536; x=1780491336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOYLvELL4pA+7Ly7GPZaewUIz4EzT8B65S7XSvB4MuA=;
 b=gpBAaSfD7JAxVF5ZENLrh/WnBbgNHOp5AneqW0Y74vahgPIhhWJMu2y9itUQDIAB0v
 1U8Fol0uOEgwdqqJ/SdfL+SNbhaIKFLteCV83Pz9EjRDoXfNZgrEJDknvRuKxFaZVzcy
 45Yn7y6b/3XVBbXrhr7ajSOKOlloRfAKyRA0tUjs1G9q7/KBACWaY+rBEeqeEXW5x7Sw
 gSiRXKVSMCJlQ4vT8Pn0bVAqkN0/PruhAKJTJayiwm100elbIS/FS5+4+IgeJmMGQJuX
 eKJBbnp5y5ebQA1eujVre2kC2K5idJwFvbsEc1rxZvnrbrV7KjDTPRRpzTaQTcbGSnxV
 JYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779886536; x=1780491336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOYLvELL4pA+7Ly7GPZaewUIz4EzT8B65S7XSvB4MuA=;
 b=G9R+tfcdLjyaAzovXFbtbbA2o7BIZIuoq3DylFM6oEnyMRGQHX1u/ARynf8ahgeceh
 cJCLiHhNAiMItS/GNicG2JydKq+NijXI3mTFDJpiAXH896eQu79jn7VShaiy4a/4bxE7
 FRdnrzxfxOrSpIlwJ+aXWoq7J/kgnTR3HT/6lAtzlrSS7AGEiY9X9tnM+zMg1P6OBjup
 hogW9Pk5OnMHIIUQpFka4gxKh38J1rwvd21XsHYI8t/wsxb7rkccD0QK3sKM/+gpg8Yx
 QwqUK/NedtFYzStEfY99kOG/Rw7Ig8a/KEyajQp7qmi2kyQZYSARCM/VwbdB4eTeX6nM
 FFUg==
X-Gm-Message-State: AOJu0YzEebts3IQbh0RmP9tgXZp2IOVelpSEPQaxIzsb59gpYbcObob7
 1i3Vxhcnp4ICdhN6ZgSDFkDpW+soL7oxiF1qdp28u8QhfR9t96OMFfTvGPK7wUfSz2H2x22YG2h
 BLcRU6BYXBwsaO1jdZhTmz57ndvxwjXJkTIh1keGZffOU1mZ2emn5XvY9
X-Gm-Gg: Acq92OGZldnFEuyHxJ2rmriuUV8AA7a0o82enDHdXJHY0+hJGfYNtOB3Icf1Qc/mbHr
 8jWvDfmrX/omyo2mX9A03e/Pu04hScVlAlTW96Oe2qZUP9VE5OGItbDD4nBgSQuvKDehQ8tcpZN
 lJ+r8dZLB3wCWLw/KgB+XUYXW2P/4nRcbKLB3lpMBOuwsor7PH7hA7Qlae1Dx4P6H86T7wpJ5xl
 VgqXaxJvBdphNi0iLhFx9feVF0DvOc5sDLeTsUriujfCQHtPIqSC7Ny40Uumt6Rmg1CEiFXlQxN
 rJ8NXjIFoc4qS7m6RWLU28zlzmltQjqhV620xyYy+j4+y54nTydgxX4tVYyx7wso9uqTfvLQMYy
 qKMa/o9pYCLvNDjH6
X-Received: by 2002:a05:600c:4e0d:b0:490:5655:8d3f with SMTP id
 5b1f17b1804b1-49056558e57mr314938755e9.28.1779886535832; 
 Wed, 27 May 2026 05:55:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:490:5655:8d3f with SMTP id
 5b1f17b1804b1-49056558e57mr314938135e9.28.1779886535379; 
 Wed, 27 May 2026 05:55:35 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561f682sm417660345e9.13.2026.05.27.05.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:55:35 -0700 (PDT)
Date: Wed, 27 May 2026 14:55:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 10/21] arm: sbsa_gwdt: add 'wdat' option
Message-ID: <20260527145534.7e96da78@imammedo>
In-Reply-To: <e443a026-3511-46f5-809a-7555789d330c@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-11-imammedo@redhat.com>
 <e443a026-3511-46f5-809a-7555789d330c@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 26 May 2026 16:24:59 +0200
Eric Auger <eauger@redhat.com> wrote:

> On 3/3/26 10:25 AM, Igor Mammedov wrote:
> > it will be used by arm/virt board, to pick WDAT compatible watchdog impl.
> > and act as switch over to WDAT ACPI table vesus default GTDT ACPI table.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/watchdog/sbsa_gwdt.h | 1 +
> >  hw/watchdog/sbsa_gwdt.c         | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
> > index 307a4f291a..dc77e6be60 100644
> > --- a/include/hw/watchdog/sbsa_gwdt.h
> > +++ b/include/hw/watchdog/sbsa_gwdt.h
> > @@ -73,6 +73,7 @@ typedef struct SBSA_GWDTState {
> >      uint32_t woru;
> >      uint32_t wcvl;
> >      uint32_t wcvu;
> > +    bool wdat;
> >  } SBSA_GWDTState;
> >  
> >  #endif /* WDT_SBSA_GWDT_H */
> > diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> > index c4dd8005b7..40d80f7f2b 100644
> > --- a/hw/watchdog/sbsa_gwdt.c
> > +++ b/hw/watchdog/sbsa_gwdt.c
> > @@ -265,6 +265,13 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
> >  
> >      sysbus_init_irq(sbd, &s->irq);
> >  
> > +    /*
> > +     * WDAT supports only upto 1KHz resolution,
> > +     */
> > +    if (s->wdat) {
> > +        s->freq = 1000;  
> where is it specified in the spec?

next patch has link to WDAT spec and
comment around relevant field:

+    /*
+     * WDAT spec suports only 1KHz or more coarse watchdog timer,
+     * Set resolution to minimum supported 1ms.
+     * Before starting watchdog Windows set countdown value to 5min.
+     */
+    g_assert(freq <= 1000);
+    build_append_int_noprefix(table_data, 1, 4);/* Timer Period, ms */

it's the hack to make gwdt usable for wdat and is applied only when
wdat is enabled, if not the gwdt is instantiated with native 1G and
provides corresponding fdt.

> 
> Thanks
> 
> Eric
> 
> > +    }
> > +
> >      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
> >                  dev);
> >  }
> > @@ -276,6 +283,7 @@ static const Property wdt_sbsa_gwdt_props[] = {
> >       */
> >      DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
> >                         1000000000),
> > +    DEFINE_PROP_BOOL("wdat", struct SBSA_GWDTState, wdat, false),
> >  };
> >  
> >  static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)  
> 


