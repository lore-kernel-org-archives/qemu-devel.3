Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B9BD2F345
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfhQ6-0002mw-1N; Tue, 13 Jan 2026 11:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfhPr-0002cd-KW
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:38:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfhPp-0001gX-NF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768322324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tti5LXV0k6YalmlO5DCUONL5OjAxITLVoua3FASz7N4=;
 b=SqSQjpmxkXevZHtFrBg00R0HU4x+DGT1vQ0me3YsVsmCBDq5uQ5IoEOD4VDM0FcYseKx8h
 1LaOrmsqgKQI8nl9YFZv3wtuzWU5txe2ilvB2bNI5gCtpKNKAxsU7TRMhKEr4lwZ1g9Td1
 Jzpu/su4od9v4BxqliD82vN0QRHZcjE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-SCdjPqTiMG2hxCfodHa56Q-1; Tue, 13 Jan 2026 11:38:43 -0500
X-MC-Unique: SCdjPqTiMG2hxCfodHa56Q-1
X-Mimecast-MFC-AGG-ID: SCdjPqTiMG2hxCfodHa56Q_1768322322
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d3c9b8c56so80659285e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 08:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768322322; x=1768927122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tti5LXV0k6YalmlO5DCUONL5OjAxITLVoua3FASz7N4=;
 b=pWYyJrTO1cHlhbo4rxPjjyH2A8xX41hXfxEUL3+7AgFXg0XU0xbxcydmEfrYpABSe9
 WxcsVikklUCvxk1PtPPw2YhgrHHCpqoCchLZQAqXbNKJs1KE7pCfiPNGsOgO2w2yjCJX
 BB3CAmHRQ1HiBO2NvrkDE07eIE3Xu2742lZeOy9Hz6Iri5+4/6YrV5wFT7m+JG/3x4eI
 /bYbf6mJ8qBr1tsPqXDl2QkbAKt3M+zu6GBLMQl0P9gumtwOroGGomGfJIG+0NBMiwzO
 2z5Qmt3VXUws1Pqp+R0jROjpTixIVKygeoj/6+6GoeYe+HgU25pfSweDwA/yHzzACI9E
 ec4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768322322; x=1768927122;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tti5LXV0k6YalmlO5DCUONL5OjAxITLVoua3FASz7N4=;
 b=HnciK2marX5vp7clP2tq8HkbLGvBj8ZM2JU5ej5sHYQ3TAunVSlufVs9ung4x8y83r
 49bn4rUOSkagyUzgSda2MXb4iZu5hRLhmE2Y3UCaQVdbE6ktBHieZbMHmxTM3LFN+MpB
 D2LigpLpMKpsJ0uSk5Ca009BoXEmTWYCEAGsJdOGow2i+BjFFJLlsNfUCI2bbYlLdbM9
 g2A1mcirUSTKANaPf5kOx1nd4wNCNhEccLVeqHNbVB1j3aXr8ph2bse5OavRDLEo7+mj
 CV1CrzM/c94oY1zIgSWzNd1VMpL+NwD5VMLx2shiMiZ+NstmzCW5h46DxZzDx8NcbQsH
 a6iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpXe4k6sQQgebhaL1ZMsAL4lMtEP+8Xw3tfUJRe/majyQ+oqaCu3bRefOF9OHVVYPY/aKWYi57wful@nongnu.org
X-Gm-Message-State: AOJu0YzLgZRJTp5AfMC7DtRRx4FpcdPETZX7hQ8N2DfBKUK/0lZ5L7f5
 iIWx8BfYMv0o34ncxjhMP4NgVgZ/UME4jewI8vs99RWKlz15qGHVWrIE0irn7/Zyf5LQHAX4IVv
 YSJaJUTXEIxbkLnqp4oo/CekMXDWHo+JozcIxei2MaAY8U8YquFDnTs6T
X-Gm-Gg: AY/fxX6jlAGQbK1TWkd3jnrW+muZLMzIH6wciHY0CvAOkN0/4V7wPEN3rFsqWuSPF9m
 By6UFXOAnr1eaGzSfpxhu/DwYEmi4aQL09BIULsPcSkxVe5Y91RMpB+/n9Sshqvhh0Evtqqz3Nk
 nqAn7FEaMh8uh75nAL3+PSHFMS3bzXJh6wlyMfBO04oM51QxiilKL6Poerey69vo69o8GJwIuz5
 vt+PhVaP1WHxC/eEiZMyt99Uwo2qahqCapjQboL6NHeoTryhFgg5m+rU4Q+kIOayW9ta1oFQWU7
 mOA+rf0ZBkErN8oDaaL5Y/T8LtzjmrvFm43NuC+H3n2inSnCTN16eEAZtTKUB2+NGjOPj0d5pjc
 TRltuf/g=
X-Received: by 2002:a05:600c:500d:b0:477:9d54:58d7 with SMTP id
 5b1f17b1804b1-47d84b3b881mr210152555e9.29.1768322321868; 
 Tue, 13 Jan 2026 08:38:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRIfCjIoPSzW/GzFb+ZHzu5opC1sOsNagLbkXRUmRCIbTM6kTqBndx09nz4S5yEjQgj6XNYA==
X-Received: by 2002:a05:600c:500d:b0:477:9d54:58d7 with SMTP id
 5b1f17b1804b1-47d84b3b881mr210152235e9.29.1768322321412; 
 Tue, 13 Jan 2026 08:38:41 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695956sm422613315e9.6.2026.01.13.08.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 08:38:40 -0800 (PST)
Message-ID: <e326c1a0-ee2f-4f0f-950b-4a4aa564d95d@redhat.com>
Date: Tue, 13 Jan 2026 17:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 134/153] gitlab-ci: enable rust for msys2-64bit
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227094759.35658-60-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20251227094759.35658-60-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 27/12/2025 10.47, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250924120426.2158655-24-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 5dbdabfbec0..5ef4d34d1ea 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -17,7 +17,7 @@ msys2-64bit:
>       # This feature doesn't (currently) work with PowerShell, it stops
>       # the echo'ing of commands being run and doesn't show any timing
>       FF_SCRIPT_SECTIONS: 0
> -    CONFIGURE_ARGS: --disable-system --enable-tools -Ddebug=false -Doptimization=0
> +    CONFIGURE_ARGS: --disable-system --enable-tools -Ddebug=false -Doptimization=0 --enable-rust

  Hi!

Note that we're using --disable-system here currently, and rust/meson.build 
starts with:

if not have_system
   subdir_done()

... so enabling rust on this job was currently pretty much a NOP (apart from 
taking more time to install the rust compiler).

When enabling a system target, this fails with:

error[E0432]: unresolved imports `libc::syslog`, `libc::LOG_INFO`
  --> rust/trace/lib.rs:8:16
   |
8 | pub use libc::{syslog, LOG_INFO};
   |                ^^^^^^  ^^^^^^^^ no `LOG_INFO` in the root
   |                |
   |                no `syslog` in the root
error: aborting due to 1 previous error

See https://gitlab.com/thuth/qemu/-/jobs/12699263050#L2818

  Thomas


