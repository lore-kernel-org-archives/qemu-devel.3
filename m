Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441A9CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ6DZ-0005jB-1q; Thu, 21 May 2026 12:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ6DX-0005iw-BN
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ6DV-0001Cf-7o
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779380747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=piptpT6soEok/x87g5hkXEwk5cb85gwGRHFVO4bjzTM=;
 b=XvmpkF/YA4Qsvzhoa/UstIwxDpii8Xti4q8bT3ClWbATU65kCej8kJtYLDrWLk7T5D9Yor
 KVp+tldh1V/X2ycJzq7W0g9Dk6MeR22hVAP9nNaWJ9fkCkewrxt4NQ/O+fmX6y88X9/cKC
 qmY39feSAfkWCyOPQJMJPGHrU1g2mD0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-fzvj8m4pOuG6Y3WxybuMyA-1; Thu, 21 May 2026 12:25:46 -0400
X-MC-Unique: fzvj8m4pOuG6Y3WxybuMyA-1
X-Mimecast-MFC-AGG-ID: fzvj8m4pOuG6Y3WxybuMyA_1779380745
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45dbbbf8d57so8202299f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779380745; x=1779985545; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=piptpT6soEok/x87g5hkXEwk5cb85gwGRHFVO4bjzTM=;
 b=aaO2c2x9x/gzpcco375tLlP5n0u5WMJgq/XsTCvGOukUIy3CacADXMPdK1/UVxF9fB
 d9l9evNC0BvFnacQbid6G4dAbUr0FXtP4apmv79IuEpBuwwpuXrzwDtEtvd0r/hVu2dn
 CT4RmPZ/uRefjfWue4foKb5B/eZ61IaAKkxBmtoIBoxmWzB0uMS+Dd6UMqsapxwnzFWV
 chqL1UlpZ5h04oiDLwZyGm/wG4r+MEYu7IiJf9CS7IoLawMvtYwGYPcLc/JlxBOOEz76
 t1waH7AEkbfOWoxwIsS1SFScuqTwnWuZHKB93oiUcrjCH1l07NUwLRDZtxTms0RSw8LD
 g/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779380745; x=1779985545;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=piptpT6soEok/x87g5hkXEwk5cb85gwGRHFVO4bjzTM=;
 b=Z7ZwyesJxw32g++FdjE30yylyHHBsCdqGYDJY4loc6jmB8wxNR/n6Aa5yPLVRABnXk
 Uuz9ioIkntb3r/EsKkZQGmpqT0dCJn33vKeDS0gTLQdn79ZHTgmxpoOKH5A2902XqAlB
 KtRdn/8bs9c9ft6dZibEKzdhaYMNXeFaMpbrpdGfJeHmjSFTywl5SpZIYu+3lta7NaqF
 egcJUpHQcGrA3uIjPzqw6ohhkCIzdBlYUIrAMV45TZfuer3LjQGJMTZOQaDrLr98PHWk
 Lc/cUzsiX7gQkYRkbGWsqDYck+sWtHqrLbSzqq7e5q4HSQhnxcnnbo3bOT/U1+4EvkU0
 byvQ==
X-Gm-Message-State: AOJu0Yw2TUbMiA7pdwZ8tYQw5viO0Zg/Ngzqrfigunda9NMNwz9ZTT/r
 OlFlSVxKMSw6rZXKxiayhQaTl0LPuNKFZSo5P08jKzj5nppZpyqIBZ4bTPUx/DDfU+oTICYJYqe
 NLTbRgeM7V3+UsgE4oWcS2pw+DGuT0x/AMFEFN/lO5aXZNppj19Tf1No3
X-Gm-Gg: Acq92OFUAq5deCTSZtGOhW7/0Jo8bsoyS0YWg9cbSdpYVhBvksn68dh1FxmajIQCMXG
 yqigObMPzUqXgcPHeJVd7LGLDcmLqqfNmNMAaHMj99wwsBeerPWqlN9Di9Z1fXbpQntyuc8QG8+
 JG7uSOR7mrpZMkue8Tqh9iLkv0gT41OFrpgXV5wH39XoM5hu6dfHk9ar2PXSX+oD/v3Z+ytZ/hG
 7nrTM4Fjj7g7lPQHIkt7TRE2vFlYd2h0zRcjlQG/+0urxOYXHM0lDicEyEmilyrQEXnHbcwsqSd
 Uh2Mw4c0OmwuqqJsq8cOdp+elgIRMK3uBY/izIMypmvMVXqVjIBxDD6R0c/a7KKu/UTbeyd9Ap5
 7AKnennDEYzg+mFRzwG147JQHxdlyv71k0nbq/97UGe8hkGA=
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-49036041d5fmr39410415e9.8.1779380744664; 
 Thu, 21 May 2026 09:25:44 -0700 (PDT)
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-49036041d5fmr39410045e9.8.1779380744194; 
 Thu, 21 May 2026 09:25:44 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49041740c10sm101515e9.1.2026.05.21.09.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 09:25:43 -0700 (PDT)
Date: Thu, 21 May 2026 12:25:40 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Message-ID: <ag8yBA7jpCo9dYR_@x1.local>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 21, 2026 at 06:54:51PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> (inherited from memory_region_find()), but both SEV callers were failing
> to release it.
> 
> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


