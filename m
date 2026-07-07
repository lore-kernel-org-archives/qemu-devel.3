Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAE2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4mz-0006ia-Mz; Tue, 07 Jul 2026 08:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh4mx-0006hu-U0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh4mv-00054e-5T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783426831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5MtvWsjBjErY3e9WbGbYw+B+rMvhKAh3aCkYbKMuC2E=;
 b=S35Zx/dcQ72+HWZRhcLK1VRDJKYKAeCdDwUR/T0k6buMDUfv3OxKg/SKHinIVOxplv6FYl
 RQMgzdfOwZ9qF8a+VedrYVAFcnAqIXSXUIaVnboNtiVLuvPMabqcOBrareB5JwqCLM7INh
 5/mTK7rIIM1aunQt5wPD8/wq9iKNIUM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-GcAr-DQhNyOkaIoVzb_t2g-1; Tue, 07 Jul 2026 08:20:30 -0400
X-MC-Unique: GcAr-DQhNyOkaIoVzb_t2g-1
X-Mimecast-MFC-AGG-ID: GcAr-DQhNyOkaIoVzb_t2g_1783426829
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c126bfee5a0so307293166b.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783426829; x=1784031629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5MtvWsjBjErY3e9WbGbYw+B+rMvhKAh3aCkYbKMuC2E=;
 b=fhlVZ9cSZ9pYELXi89DQEPrtihALuSUvY3TVY+wNV8XCTwlp72R+s696Kesq+iBwtS
 ciPXn/nlTIBrxyceDyqr9XT6bdIdXD7mYFN903RkaOtze+z5aXpEIl72PIAYehEjAPSk
 ljKhvdVQzreG/07o/cTOXX+By2FVoLvcxe+eoYD8tYTrQVyYoCvSioCKsnQGsn2cce5s
 rh9+UJlT5z+Zr039/x2Qo9I+QkDZ3zhGAb8jmMXLo+yuNBbKN749SSkBXLaZ2VkCaLAB
 ZN0PqtFUE2mttk0LGbAsIQAuGTDd/XXJXC4BsP85Si83bPA2+m8JIxpshbE2U2hShfUH
 azOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783426829; x=1784031629;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MtvWsjBjErY3e9WbGbYw+B+rMvhKAh3aCkYbKMuC2E=;
 b=Wbxr3iiT2Bs3ABKWjhNRW+w1p0jgNfEtx/5grZMrcDRGyz+UqNzifos9AHf1nZMnJP
 E41pfy5VpY8n3qYLnY/wOUSRixeH/XDCFHjEb2kUwvA6277T7DeduWGULE7cZUl1CDhj
 gngRW61/J6SVPdZFdBVMtuT+S5JE35LcBR0anCgmB0dg3sKz2bYV2J+3QfcnH4fy9s2u
 Yfdrsd32UjkqOl0FIj7jmRtE860cOC/FFVLtWTg7123gNGIanCzCoiXDVqKcTOZUxW7j
 CXieq5HDTJy8FY3Cn70OwkrHwZzzCOR+2qdYOnG3fZzlqmPTmF06h9gzLy4vCuNVeuO/
 qDKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWmeJxmKmvWFFvgjedkxArVKzoTEX95e6zu+UcTCa0e8zML9Cs3EfyjqLHp96hBPy/Ss2kfZsdcIm+@nongnu.org
X-Gm-Message-State: AOJu0Yyb1sTehyA17NOhPnlJ0M/5/hVK+ybpi8eVIDyTEKUzZAXf0Xo9
 ORcL35ZJfObFjwxpr+36ip6SmpkM4RKaSbiNlI7KxNf0gKcpnbpZyLltG5Mp7kfDWovi+HTiMmN
 /nTevzBTXVUvQC/skxR/tdSi/Q6mBBCTswbnuJvSzbch9H92pepCxHi90
X-Gm-Gg: AfdE7cmJvuB3yJgqcy6dEhRyHXhd8DaJjCr6CWMfMMaH+mwP+OZf8QzNVCgVKbzy4oq
 0XTKY0R1avcnf3IY7bXpen5xwD28sd5CqqtBsIWASi2Dq8o9jiXF5D4zIRZuEjE1uOXO0edt/0d
 CwIVDTDAz+fGiBnNbNWcNIVJWMudp70Xlb59OaGQ5sJeyN5ZQjm5sHLICRqKjk96KbcSaCgtW8p
 w/u/FKXwA+rWr3AYBASJnCUIvNi2+XjY15NHKc7Le+Wwv8GaQLnr3wPncCESSm14BfJiW8i+YYm
 bBeYB843V8gmbBBo6jIiePhaiOjPziSUVS8Dnktd4UyVAHKnI8Yv5sCy3vubdHpsRztlbs5Dxb5
 uGm4mo2UoQ0u1tIhU5QYoS5NqR/3ugE8FkJozfXfaW8z5u0MaCw==
X-Received: by 2002:a17:906:1558:b0:bfd:6cf6:1952 with SMTP id
 a640c23a62f3a-c15a683e7aemr198737566b.28.1783426828991; 
 Tue, 07 Jul 2026 05:20:28 -0700 (PDT)
X-Received: by 2002:a17:906:1558:b0:bfd:6cf6:1952 with SMTP id
 a640c23a62f3a-c15a683e7aemr198735766b.28.1783426828479; 
 Tue, 07 Jul 2026 05:20:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9be41esm119489766b.39.2026.07.07.05.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:20:28 -0700 (PDT)
Message-ID: <f858c0a7-bcac-4d50-b9f4-300be46428ac@redhat.com>
Date: Tue, 7 Jul 2026 14:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: outline some guidelines for security classification
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260707105927.2776822-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 7/7/26 12:59, Daniel P. Berrangé wrote:
> Beyond the overall virt/non-virt use case classification, there are
> a number of scenarios which we have decided will not be treated as
> security issues. Start to document some of these to give consistency
> in our treatemnt of incoming disclosures.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> Mauro / Michael: please suggest any other rules which we have applied
> historically on qemu-security disclosures that we should capture here.
> 
> The vfio-user/vhost-user addition is a new one based on discussions
> in some GitLab issues today/yesterday
> 
>   docs/system/security.rst | 63 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 53992048e6..fbbca50f95 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -75,6 +75,69 @@ Bugs affecting the non-virtualization use case are not considered security
>   bugs at this time.  Users with non-virtualization use cases must not rely on
>   QEMU to provide guest isolation or any security guarantees.
>   
> +Security boundary scope
> +'''''''''''''''''''''''
> +
> +Even where a flaw affects the virtualization use case described above,
> +not all scenarios will be considered in scope. The following guidelines
> +are used to evaluate whether to apply the full security process, or treat
> +an issue as a normal bug.
> +
> +* **assert** / **abort**. If triggering the code path requires kernel
> +  privileges (or root account access) in the guest, asserts/aborts in
> +  QEMU are a self inflicted denial of service. These will **not** be
> +  treated as security flaws, at most hardening bugs. If triggering the
> +  code path can be done by an unprivileged guest OS account, this
> +  **may** justify handling as a security bug.
> +
> +* **vhost-user/vfio-user backends**. The backend processes have
> +  shared memory regions co-mapped with the QEMU process. The intent
> +  of the process separation is operational resilience & flexibility
> +  and allowing for independent software suppliers. There is not
> +  considered to be security boundary between QEMU and the vhost-user
> +  & vfio-user backends. Thus flaws in the backends which can cause
> +  crashes / undesirable behaviour in QEMU will **not** be treated as
> +  security flaws, but should be fixed as hardening bugs.
> +
> +* **memory allocation bounds**. There are many ways in which a QEMU
> +  process can legitimately consume an amount of memory that is
> +  significantly larger than the assigned guest RAM. QEMU's worst
> +  case memory usage should be considered effectively unbounded. As
> +  such the QEMU deployment on the host should account for the
> +  possibility of large memory peaks and apply countermeasures to
> +  provide continuity of host operations. It is typical for the Linux
> +  OOM killer to reap the process triggering host memory overcommit
> +  in the case of exccessive usage, offering a degree of protection.
> +  As such, bugs which can lead to excessive/unbounded memory allocations
> +  will usually not be classified as security flaws, but should be
> +  fixed as hardening bugs.
> +
> +* **degraded guest behaviour**. There are a set of bugs which can
> +  lead guest hardware devices to misbehave. For example, a flawed
> +  virtual IOMMU operation may not offer the guest device isolation
> +  that would otherwise be expected. If a guest triggered exploit
> +  requires kernel privileges (or root account access), and leads
> +  to sub-optimal behaviour of the virtual device this is considered
> +  a self inflicted service degradation. These will **not** be
> +  treated as security flaws, at most hardening bugs. If triggernig
> +  the code path can be done by an unprivileged guest OS account,
> +  this may justify handling as a security bug.
> +
> +* **nested virtualization**. The scope for nested virtualization
> +  is to prevent a level 2 guest from breaking out into a level
> +  1 guest. As noted above, a number of scenarios exclude security
> +  handling for flaws only exploitable by the guest kernel / root
> +  account with affect the guest's own service/availability. In the
> +  context of nested virtualization with PCI device assignment, it
> +  may may be possible for a level 2 guest kernel to trigger flaws
> +  that affect the level 0 QEMU process. While these bugs should be
> +  fixed, they will not be triaged as security flaws at this time.
> +
> +* **low severity impact**. As a catch all rule, issues which
> +  are judged to have a "low" severity impact on the system will
> +  usually not justify handling as security bugs, nor assignment
> +  of CVEs. They will be fixed as routine bugs when time allows.
> +
>   Architecture
>   ------------
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




