Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2BBD3C908
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 00:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Jky-0001Fe-7O; Sat, 19 Oct 2024 20:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t2Jkw-0001FD-DR
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 20:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t2Jku-0006uo-Ab
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 20:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729383908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvw50wVORKIfWSnXkRoGS7iwCbT0dnFS0KOL060uOz8=;
 b=TNSp0MkpxghRPnpHfMyOi73sKUNn4KgSbuHjEk0gQsyNGcghZpLKZWvV901dMG2E+a4TpB
 ZpPGjQkDFlidb4e9Oo4BSfjRbiuvqKFoqeE3VCWdLQsyy87rIU0Tmqwyi4q9kBrh7ujtCw
 nna+zh+hkEiVV6/w8s+sw9y1ZZjHZ9k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-vQTOhQdnNaOQMG4BMge_2g-1; Sat, 19 Oct 2024 20:25:06 -0400
X-MC-Unique: vQTOhQdnNaOQMG4BMge_2g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316de700f2so3463595e9.2
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 17:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729383905; x=1729988705;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvw50wVORKIfWSnXkRoGS7iwCbT0dnFS0KOL060uOz8=;
 b=P7Hth+NPsJghIi6NTU+lF3gFrzqZeMJmPNhaaiMXWCA2OE+IQlPjPQf0kM0JWTyElL
 cE5fN0C54H1Ym9ax+pwuciUXXWN58y0slIZLl/OyfCRoTj+VLKVyzuk1Rqm4D2x3EIX+
 pQg1LYHus2kUnKfP3Hc2RitPtMOPEOVEBmjBbrZnwMPjJC9faLCsh3wykM6lh9LggTUb
 UaB0R5fG6aVsWtjnkuLutL+h+8/zDHiY1JYB8VL8QNudlS4qAuE40cWPcb48guitmwMz
 nxdY0PcCGjHDRFQCAVI5WrQkLUKtrVe8UwAG5TupJoj+jQurGwCRuLvBKNNUZQM4xShP
 1YaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrDKxRk338QUReT7xy1aiDF9sWqJ1V2HEnuuHgvLPfYFjbpl41vLmgkJwgMZoHOb0vjK+nAPp1QC07@nongnu.org
X-Gm-Message-State: AOJu0YwRXKcrMbEkaE4hR7Vdj8NfNaeHF93q4WdMQVOq+2z1fVJ45h83
 XJTOVIeJ1baTPJFb/3BR3tGw80JXEDL/NBucbdOA4Y/rcOvgKizWXlpOQPZitsb8lT4Bx7GD74s
 l1JYigxwaviZcY3W6zV/W3FpobzkeZe9A1MEoJE/lCOiZGsrPlx27
X-Received: by 2002:a05:600c:5120:b0:431:5533:8f0b with SMTP id
 5b1f17b1804b1-431616a3a96mr54681775e9.32.1729383904993; 
 Sat, 19 Oct 2024 17:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+g3bl+/izovNmul847299Mtm1dab1fu+xK9SWhM2VVTWpoDTV6u3AwoZCN/YnUULpW6ggkA==
X-Received: by 2002:a05:600c:5120:b0:431:5533:8f0b with SMTP id
 5b1f17b1804b1-431616a3a96mr54681665e9.32.1729383904625; 
 Sat, 19 Oct 2024 17:25:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58ae0asm8000365e9.23.2024.10.19.17.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 17:25:03 -0700 (PDT)
Date: Sat, 19 Oct 2024 20:25:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to
 control Transient Mapping (TM) field
Message-ID: <20241019202416-mutt-send-email-mst@kernel.org>
References: <20241010075354.3582221-1-zhenzhong.duan@intel.com>
 <CACGkMEt+M=nEiivOM4OPm6jxe9ygDm-41nDxQUCBMskETFAO8Q@mail.gmail.com>
 <SJ0PR11MB6744C0B9DE8D32354242099992472@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB6744C0B9DE8D32354242099992472@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.25,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 17, 2024 at 07:57:53AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Subject: Re: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to control
> >Transient Mapping (TM) field
> >
> >On Thu, Oct 10, 2024 at 3:57 PM Zhenzhong Duan <zhenzhong.duan@intel.com>
> >wrote:
> >>
> >> VT-d spec removed Transient Mapping (TM) field from second-level page-tables
> >> and treat the field as Reserved(0) since revision 3.2.
> >>
> >> Changing the field as reserved(0) will break backward compatibility, so
> >> introduce a property "x-stale-tm" to allow user to control the setting.
> >
> >Nit: I think we probably don't need the x prefix? As we try to
> >maintain the compatibility via:
> >
> >> +    { TYPE_INTEL_IOMMU_DEVICE, "x-stale-tm", "on" },
> >
> >?
> 
> I'm fine to remove it. But,
> The prefix "x-" is used to indicate that a feature is experimental.

No, it is used to indicate that the feature is not part of
a stable API.

> Couldn't we have a property both experimental and compatible?
> I see a lot of such properties:
> 
> # grep "x-" /sdb/qemu/hw/i386/pc.c
>     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
>     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
>     { TYPE_INTEL_IOMMU_DEVICE, "x-stale-tm", "on" },
>     { TYPE_X86_CPU, "x-amd-topoext-features-only", "false" },
>     { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
>     { "ICH9-LPC", "x-keep-pci-slot-hpc", "false" },
>     { TYPE_X86_CPU, "x-vendor-cpuid-only", "off" },
>     { "ICH9-LPC", "x-keep-pci-slot-hpc", "true" },
>     { "ICH9-LPC", "x-smi-cpu-hotunplug", "off" },
>     { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
>     { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
>     { TYPE_X86_CPU, "x-hv-synic-kvm-only", "on" },
>     { TYPE_X86_CPU, "x-migrate-smi-count", "off" },
>     { TYPE_X86_CPU, "x-hv-max-vps", "0x40" },
>     { "i440FX-pcihost", "x-pci-hole64-fix", "off" },
>     { "q35-pcihost", "x-pci-hole64-fix", "off" },
>     { "kvmclock", "x-mach-use-reliable-get-clock", "off" },
>     { "ICH9-LPC", "x-smi-broadcast", "off" },
> 
> Thanks
> Zhenzhong


