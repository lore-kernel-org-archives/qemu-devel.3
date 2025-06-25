Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6BBC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 16:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUSlv-0006VX-Dq; Wed, 25 Jun 2025 12:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSlt-0006VD-JK
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 12:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSll-00054g-Q1
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 12:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750868076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HtbGLSt/Y8dho6FP87GhFqZjG+wSTT5omAoXASAT+c8=;
 b=USvZYD5uV19MxD8hAo24A42L3YFllrBi0X50HTqaL801HWlRs0V9CRvv0FV31fNSegCX7n
 QRu1zmU7X+MEy6TTz4+LAm0jcd9dW6qE7G+c9AOYWD6H01yrkhMDz6C3ESnW1RE/3cLC9x
 j6s7NVyZE4AGVfOvcIdqO8jaTbi2OiI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-kAkn15S0NliMKhTZkgF51g-1; Wed, 25 Jun 2025 12:14:35 -0400
X-MC-Unique: kAkn15S0NliMKhTZkgF51g-1
X-Mimecast-MFC-AGG-ID: kAkn15S0NliMKhTZkgF51g_1750868074
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so2781333f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 09:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750868074; x=1751472874;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HtbGLSt/Y8dho6FP87GhFqZjG+wSTT5omAoXASAT+c8=;
 b=PUNIB45Ykyfp5gpS8L5dyO7Zu730ypimugtRQ5JadqCKomY1TqbumZkwkYr1oGFVqi
 UpHK055Uw3ejRVfZ21GqA3eCyj62XsVRdLe2F9+mVMCkZLKKjEac+D89EhaNEZflaiBe
 CAlH6+xtFCsDXVVQo0h9fc11f/syDdUtxAoJL0uzBudoGMgEMAczuO0KxAd5qmOjFXgP
 mkWmsMlrfJoEsNx+0+CjWvD8NUJpZCPZLjHIrNo73PNAigJn1YCix7oKJdk15J3tKzJ5
 Z6pLMBjQDwgLkfwxdCq6W5YNnoSeiTcP4Wxgs+NJ1uBQQPsVjNubnZmsS7v3D3zLZiw9
 lUjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/GDBrfOZ9b2gSihcoPRSuB69fmMxq+4zOn8WHRUsKLxU2QGpfp1f4h8dSyRFkW9BxKspN26KHG7o1@nongnu.org
X-Gm-Message-State: AOJu0YwumX/vewcTgK4IYI2ZyRSd0h4BIOpK+0qhTFadCMlBF3wtxYEp
 2GvMlEnH60ZXQsS59BOSKhp4FXpqxKVx09AsJTBVpqLK2SVcvBHXcMJwy+oEzDnAO2XPjFd0dfl
 Rt1sDbdLDL3CWdUh4vKUt4TiK29twV4WuUn0BB0oQTdIICic91TSs9TKBD9rH/KED
X-Gm-Gg: ASbGncthjBU0+0htosdBDKsQt668Ia3/gehLNyNCQDeujlEjeRaEQtjRU3uc+C2CEkR
 IpAEJunGwoAw1zQnxKXJp1aAfDkyK4JR4m6nSdfne4UEMJjzQv+Sp/AB0BPqgZLKCMpt+D+0Gkk
 Cjcj8gi/v8ELLoKbXXa11CqzLc2ZqmpH9Kru13mepyGMkC5SkiZe9CFSYz3piMf+5+wdyky63Bm
 eHsJAVdrfDaaPF0sU8YZNkjfKiycLAfh6Oti68bPo9pHBpRZnFCJnpfxOURGgkMxT8BdDhPMUE2
 1HnQHHI1Dv4/LIAibStw+H80E3KUPuWHlOx1h5zIsMk1tr2Htv46bOE5D7vhKBU=
X-Received: by 2002:a05:6000:25c5:b0:3a4:f900:21c4 with SMTP id
 ffacd0b85a97d-3a6ed643899mr3385823f8f.26.1750868073902; 
 Wed, 25 Jun 2025 09:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH1CL6lXp2n4a0RTOyEIgv62rPxIuAtcKWDsFhbQJ2BgJ85lq/4yeX6MtoItWHB9PzjP9Uxw==
X-Received: by 2002:a05:6000:25c5:b0:3a4:f900:21c4 with SMTP id
 ffacd0b85a97d-3a6ed643899mr3385797f8f.26.1750868073543; 
 Wed, 25 Jun 2025 09:14:33 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e806916esm4993500f8f.43.2025.06.25.09.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 09:14:32 -0700 (PDT)
Message-ID: <adf47487-83fc-4e2f-bfed-1a608fd4263a@redhat.com>
Date: Wed, 25 Jun 2025 18:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Replace FSF postal address with licenses URL
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250613.qemu.patch@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20250613.qemu.patch@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/06/2025 18.30, Sean Wei wrote:
> The boiler-plate licence headers in several parts of QEMU still contain
> the obsolete “51 Franklin Street" contact line.
> 
> The Free Software Foundation now recommends using the canonical URL:
> 
>      https://www.gnu.org/licenses/
> 
> 
> This patch updates those headers. The patches are comment-only;
> no source code changes.
> 
> Please review and let me know if any patch should be split, squashed
> or dropped. This is my first patch for the QEMU project, so any
> feedback is greatly appreciated.
> 
> Thanks to Thomas Huth <thuth@redhat.com> for proposing this issue and
> outlining the steps, and to Daniel P. Berrangé <berrange@redhat.com>
> for the clarifications.
> 
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2438

It's rather https://gitlab.com/qemu-project/qemu/-/issues/2974 instead, but 
anyway, thanks for tackling this!

I'll queue the patches (except the one that updates linux-headers) for my 
next pull request.

  Thomas


