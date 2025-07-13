Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B2DC83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 21:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub4GQ-0008OG-Ck; Sun, 13 Jul 2025 17:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ub4GN-0008Mn-N3
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 17:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ub4GK-00081B-Uc
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 17:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752442170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W/Gsg0ZI00nd82dn0kieScncAne+W6SSif+tT5TbTHU=;
 b=RLZE5VaUqWzmrpjljQFVd+mJYjEJe4gj0GT2b+EIG7+tlo4lfDWV7ITxkMsolSLG8e5co3
 tfxTJM9HkYsin6yX/+X49ihpTc9Q8FjhSNvq5x37MEXog0imCqH3LCvM7pH8ckhGqvnxwo
 bcIXnnFc/26FCZCE9ulvDDcWcnvwxwc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-vwupHkqDN0WAlHMVCt9gUw-1; Sun, 13 Jul 2025 17:29:29 -0400
X-MC-Unique: vwupHkqDN0WAlHMVCt9gUw-1
X-Mimecast-MFC-AGG-ID: vwupHkqDN0WAlHMVCt9gUw_1752442168
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so21028375e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 14:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752442168; x=1753046968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/Gsg0ZI00nd82dn0kieScncAne+W6SSif+tT5TbTHU=;
 b=HXRg55FcYoj0safziye3ULAiXY2eaBzL1e0feZUFW/TwBJgp/G0EXzY9WelWFUYShn
 LY4nEW/k10rpAoaFyfwC+vz+aUIfbYFxsRlXrnSocxxKgVo/iAWNlPiM7tBvVtJEndlg
 /U9YJwqSSkwxc1nAmRX0YPOfuQUanBEr7HUPWWgLF0dSdgK57kBBvZRgGfv6DcWAAbkB
 RvLeMtfHc44f0wojyqbnUqwo1P+ftit4ohq3I9dNt3toYuPIlU9hpSDnMmlLVXNq9x+A
 I+kaI6pVwjfSVFbwsQRwJgl+qKGgKcrtd6OnU0SgiNysb3CcailDv2cyTl5N2azsSrWz
 Ag2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSvcq99rPQqYVYfuK/9ZTUH6ycWmIuxT2ZYFxEnHODpT9f/BnI+502C3P96Pv7r0VFrhoaN0y0m8yk@nongnu.org
X-Gm-Message-State: AOJu0YyzPIK3STxOFMnRB0j3qgAr6kyyUahWn9P6oQmJ7mzUNOb/G21m
 rnunFRxjadi3/yypyol0fAO6+5TC22E3qzDIAnvn/gRTmRKZ2sMHjeq49hbG40n87icDTc0Ovyl
 5qmEZ56/EU0XXOUupFRidxYT5nbbWCWCovZfJ9P2z1i06vi6vIlwcHHHA
X-Gm-Gg: ASbGncs9+/WCq8GkasIFcCnZzosyLgy0ze5/kd+e8BQbM/XULdi0vqmsl9znfaBOZrN
 ITCeyoumJ8iEbOQnmEXLaQB4Wl7QDp75rCkZQZsLC/3lUaru0S6sQMyKO6JbHr/6T7cLpl3Y1/i
 94y4NtHppa4N6QE7YeMuLHvOVVM2Q1zG86nUDdpGQy+PIicvOi+QDNEwLPvKCCaMLdDeO6i+6Ub
 p5rp37agS9muR+EROhjWlG+y/CJZDhpQ7wabPMTJ3WmrYjUq7TKbJshRmUuU7lm3hS+C9STz1Qj
 /WwiZ1Joc8Xy+E554y+sBYPwLyU9qIsg
X-Received: by 2002:a5d:6f01:0:b0:3b6:463:d85d with SMTP id
 ffacd0b85a97d-3b60463d8eemr1003467f8f.11.1752442167869; 
 Sun, 13 Jul 2025 14:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiZb5hZQRQuC/zpFpMYZ+ois9WWHfhoBfF/RoGhfQ+fMGyVgcKpkighNX/smyWClsyiKVoZg==
X-Received: by 2002:a5d:6f01:0:b0:3b6:463:d85d with SMTP id
 ffacd0b85a97d-3b60463d8eemr1003456f8f.11.1752442167364; 
 Sun, 13 Jul 2025 14:29:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2025sm10841351f8f.31.2025.07.13.14.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jul 2025 14:29:26 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:29:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Wang <jasowang@redhat.com>, Le Tan <tamlokveer@gmail.com>,
 kib@freebsd.org, Yi Liu <yi.l.liu@intel.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH] intel_iommu: Allow both Status Write and Interrupt Flag
 in QI wait
Message-ID: <20250713172820-mutt-send-email-mst@kernel.org>
References: <e15012b9776a25cbfdbcc9797595669d3ae4ef36.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15012b9776a25cbfdbcc9797595669d3ae4ef36.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jul 11, 2025 at 10:47:47AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> FreeBSD does both, and this appears to be perfectly valid. The VT-d
> spec even talks about the ordering (the status write should be done
> first, unsurprisingly).
> 
> We certainly shouldn't assert() and abort QEMU if the guest asks for
> both.
> 
> Fixes: ed7b8fbcfb88 ("intel-iommu: add supports for queued invalidation interface")
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3028
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Still can't get FreeBSD to boot and use CPUs with APIC ID > 255 using
> *either* Intel or AMD IOMMU with interrupt remapping, or the native
> 15-bit APIC ID enlightenment.
> cf. https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=288122
> 
>  hw/i386/intel_iommu.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 69d72ad35c..3bfaf9bd07 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2822,6 +2822,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>  {
>      uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
>                          VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +    bool ret = true;
>  
>      if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
>                                       __func__, "wait")) {
> @@ -2833,7 +2834,8 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>          uint32_t status_data = (uint32_t)(inv_desc->lo >>
>                                 VTD_INV_DESC_WAIT_DATA_SHIFT);
>  
> -        assert(!(inv_desc->lo & VTD_INV_DESC_WAIT_IF));
> +        if (inv_desc->lo & VTD_INV_DESC_WAIT_IF)
> +            vtd_generate_completion_event(s);
>  
>          /* FIXME: need to be masked with HAW? */
>          dma_addr_t status_addr = inv_desc->hi;

Follow QEMU coding style, please.



> @@ -2843,18 +2845,22 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>                               &status_data, sizeof(status_data),
>                               MEMTXATTRS_UNSPECIFIED)) {
>              trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc->lo);
> -            return false;
> +            ret = false;
>          }
> -    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
> +    }
> +
> +    if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>          /* Interrupt flag */
>          vtd_generate_completion_event(s);
> -    } else {
> +    }
> +
> +    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF|VTD_INV_DESC_WAIT_SW))) {
>          error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
>                            " (unknown type)", __func__, inv_desc->hi,
>                            inv_desc->lo);
>          return false;
>      }
> -    return true;
> +    return ret;
>  }
>  
>  static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
> -- 
> 2.43.0
> 
> 



