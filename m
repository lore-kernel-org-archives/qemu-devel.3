Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12EAC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4im-0004EN-W4; Tue, 07 Jul 2026 08:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh4il-0004ED-9D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh4ii-0004Uu-Od
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783426570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YZfWQjpQu5lTifbeHG4RYZQr2lEtCdTgOxeFhKeGq5o=;
 b=DXnh7LPCP5h3DTjQI3/OpMKz3JMXXL507MDcm7vYwYswu95UBr92ZT0s4h2/hTmpDW/r8V
 ypYU1tXJt0CDsxn9iHH/cDI0WGu41mQqVXJI3GvN1m6c1y+2SCwHqiqmCh6slUQRRe0MmF
 AeahQkdphRfB2vLDuTAkoVh3y4biBZk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-6O2AdEYFNaagk3OmI-tkeA-1; Tue, 07 Jul 2026 08:16:09 -0400
X-MC-Unique: 6O2AdEYFNaagk3OmI-tkeA-1
X-Mimecast-MFC-AGG-ID: 6O2AdEYFNaagk3OmI-tkeA_1783426568
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4760c900cf3so103237f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783426568; x=1784031368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YZfWQjpQu5lTifbeHG4RYZQr2lEtCdTgOxeFhKeGq5o=;
 b=ladrUIPiBdCRIYkw91FB9tFJ5zNArUiCNXUhucWrlN3koha+HnfncOFGJYcAI/i/Zy
 ix2jW6syE7N7ngYnY52IYDES25bdghCQbqbiZ4pDfEgoqWoLPfz+hUYn9IG3ifVPvCuP
 FqSkVNpr6uwe45FRpu09pkaYMzD6LhBCXMXX4DS0ccZkeyec60jrzGpgUYZa5KBjiS3a
 eR+UMnuKF16boCe8oGrML46mP7uQsRSkonwbeess+cABbUTdx8Z6wpDUxpjfP1kjOwPX
 dGd6MY9vB5oAVAHpdI2kFoY/qcCjval0YdrnOnZWnip0zcuk9Q9x78dCcqTL8yW8kHnQ
 O+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783426568; x=1784031368;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZfWQjpQu5lTifbeHG4RYZQr2lEtCdTgOxeFhKeGq5o=;
 b=mSYdEYPfB3hSn8UROKPILgFZx6bORofEOMLnaZw6KTsuHwoOJfFLjd3vzrc8SLnS+x
 Tb80HuBGmqZRWR4MPuFGXDlKUPmxVUgEpyx7zd0CWt/ZM1U+ixUobLofVy0zLi9Q49Qa
 eI1V8sI/RLqgEyr0gJOkTtpJsZpGmxmxAwgtnR687l97+B35NwCKSFTjjZInEnCvFxHr
 vzQJ4kbkwnwSyRQgUlxqNJHVN+eKZg7VLrdnCZvx9hNAzDd1axVFISFN+PkdJV8kccbx
 wf89n3z96jL5mOeAKgVc1yB71vO0mSZjuRQiN2+nfOxH4P27T+vm7oYN0g7xqClFgnix
 rJpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RogmPNytx7hH6MVbrJK8/7J/5mk5MGS7RHJuBdL26w31njvJvTsyMRUFxfWNGgbMa9rquwU+lrXSK0G@nongnu.org
X-Gm-Message-State: AOJu0YxU4W1AvMummFmDJpmG0mgIdOG98uakW41MTOOPhRcyjqNttQi+
 s10YpZ2PP9cCukaImIxcLQ0e/swJYF0g0cJyI74YuW9Fa4SflyVEdi/tl2NxasFvfa7wCkAfog1
 pnO4d7Rt0Cmfaf6CbCxFHnnHok5YK8Ozu43y9aMLrMn3vggt/gVhQFYaW
X-Gm-Gg: AfdE7clRhtLQg8hELhZk3RLKkOoZAvUsdSKxF+SyITYm1r8VftQdn/Nqe1Lz85ThcRI
 BogVrPU+UOWwKhs+qaaan4eus8mVLlR47e4owjqb4zQl1uMgn3/lKfgj6cYz5QZHGZEPwesMlLC
 DiLcC2JzHjFx87aVSvaw/F/2JfBus2nEx1XWgUdbxrNh4G3xwrf3PRD631oQuxAfA2JgdTBfjLx
 +IDK+MJMdMphYAF6HSjyDpTgtxquEvPy9V7lAytvvoz2bSI3AwwWlYan6jBARBF5rUJBdfjkmNi
 BeSJwPHVHiVwb9X7wIlRKaxtXYvI63CXSaNdT2kQSSzXJeUdIVfS8dBF06HiWlHobq2UFy1X/F6
 ENw020Q==
X-Received: by 2002:a5d:6f02:0:b0:473:fc10:f675 with SMTP id
 ffacd0b85a97d-47de9a08ademr3107086f8f.18.1783426568066; 
 Tue, 07 Jul 2026 05:16:08 -0700 (PDT)
X-Received: by 2002:a5d:6f02:0:b0:473:fc10:f675 with SMTP id
 ffacd0b85a97d-47de9a08ademr3107015f8f.18.1783426567387; 
 Tue, 07 Jul 2026 05:16:07 -0700 (PDT)
Received: from [10.22.2.34] ([91.26.127.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae44sm32441455f8f.23.2026.07.07.05.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:16:06 -0700 (PDT)
Message-ID: <e1b8b3f2-20d2-4446-a388-d1b547985d2d@redhat.com>
Date: Tue, 7 Jul 2026 14:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: outline some guidelines for security classification
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260707105927.2776822-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/07/2026 12.59, Daniel P. Berrangé wrote:
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
Reviewed-by: Thomas Huth <thuth@redhat.com>


