Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D97FC55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrprY-0005IF-Ei; Thu, 06 Aug 2026 00:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wrprU-0005Hu-EL
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wrprS-0004bi-90
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785991060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zt5MP1PvIisvT5REvDWv0hrZLsax7dqTwhNkMf8dFc0=;
 b=D+A9J5fFnqyKU3/CjcOALCHa0oxKB5sC8vwTBj6LYmgB2m3Dv0LKW0X3oP6ymqgARzxklQ
 JooSvPQKpJSqIuYs0pSJ58hcVELfGe/WcloFriJ0ss1RVEIPlfvvpHBbRqGPq7tKWn2Abp
 uwvgUYMQ/XsX0cB/H5E7f6D06FFTmsQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-UfSflREbPlKwKxdMbnA4Xw-1; Thu, 06 Aug 2026 00:37:38 -0400
X-MC-Unique: UfSflREbPlKwKxdMbnA4Xw-1
X-Mimecast-MFC-AGG-ID: UfSflREbPlKwKxdMbnA4Xw_1785991057
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f8398ed9fso1322927f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785991057; x=1786595857; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zt5MP1PvIisvT5REvDWv0hrZLsax7dqTwhNkMf8dFc0=;
 b=J9IOKWuyhj+MEEV38Vwwk0D19/Nw0YJpIM6mYAaGAzuzS+hvj7tbmgTQBsOHDklPNL
 INO8RrHjdSM+UQ8wnK+UL1+CYPljt4LFSOiLZpvHeIXJ8tXrusznQm95TQDvXjB9g7mM
 1QwvSgPBdT4zbOHmxguPlWEp12ZjjHjUjvuajIjXZQv6xDJWxCyKtVAgEtMS/a1CIHUT
 baSxbyuec6S84iO2l8T7F6i55ENBSxAMSEXB1+7aRw6IHr+aRHdWecIZaWDJs5IeWYZx
 A4aZQECoqeHGQRrp/rgtVaWAFf7dDsdz0wrP1n5fJdmdptvgYZPi8CjKYeiS9xECvJIJ
 U+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785991057; x=1786595857;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Zt5MP1PvIisvT5REvDWv0hrZLsax7dqTwhNkMf8dFc0=;
 b=sd9hjnKqg9Sfea6XGESKbnwZsaQvmXzNd0z3H6hTTlTeRqJkOPVedzbhxvp4sx1/YO
 NJirZ4TjSyDQ4jQc4kp/B8O+lSqnJLGzvAGcrs1WRGYcODkkoSS8YMSpoAlPTGARE/iN
 A6MAxC5ton6uiAGzZNxMoWaVAegLfRqVYPTW2ses+5jOw+8yr3nP3HCo61txzQtdRlmH
 59x3j0aniKDQcYaQOyOgnFlkVgbprcUUyQ2pF7hmbal95PwGRoKrpNJhFrdMCydSXTff
 qxRSanhMlJlIq6PQtCx9fejP9RepNuuzuJ2bpT2Ecmk88KvcgcHaONiZQeiVzRoqC0aM
 lPhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RobP6zUi01DwS5v78Z00HDK+ihwTL7DiVQkA/CJCehYzEBEbUxnj2SJEjP3Oj2FSd/UniVe3P4nU1UV@nongnu.org
X-Gm-Message-State: AOJu0YxbBlvujuPOpCo2zYI2zPiRYCNUs+rp4dICcKrsZIQqtjjQ6ae6
 znKutirGYwCg2xGrUroyXKxRlY6YNPHr8bdphdQgxr1xdUHyo4kwWC8tzzQWNB1/xasbQiHFn4X
 9Y+uxXqtNworvcDX828iAASuBqHL0/NoTx6HtgkYnpU1AHuWUIaaodM4o
X-Gm-Gg: AR+sD11t6r9nmEfJkN/L97NoCoH7ngUkxVcOyGAzVETm69bdy/tZht2w2Z41bWZwzCg
 tcWqxoRErlzg/tyZFJkVTOgWYOIq0D+auWOMuMF027HnTDonGNSe08OXz0fBbD7PxaAnT2PXdoF
 4Beh1ex90QTIPufI4qbN8MgxRvYHRieVIwFm2Xw4tfNAjiAO6yRKawlRfEkDB7a17jTQkB2IRWK
 YSR3XEHuLMoSuPF7qrtew8irkKN5pwbMAdzTA4eQR+yAmaewR+kYCbStZ3dXUYYxuSlPKH3psmk
 DKL5YnvaB5moZLl5WT3b6XfO9B7wu4/l6Ok8SPpiLjzzc03dGpHPR7vbvgpqlklTqBJjnUJP
X-Received: by 2002:a05:6000:4b02:b0:47f:70f1:a577 with SMTP id
 ffacd0b85a97d-47fec62d892mr20072915f8f.17.1785991057525; 
 Wed, 05 Aug 2026 21:37:37 -0700 (PDT)
X-Received: by 2002:a05:6000:4b02:b0:47f:70f1:a577 with SMTP id
 ffacd0b85a97d-47fec62d892mr20072887f8f.17.1785991057185; 
 Wed, 05 Aug 2026 21:37:37 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.28]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b18086sm3009246f8f.22.2026.08.05.21.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 21:37:36 -0700 (PDT)
Message-ID: <e8921043-2405-4b20-95f8-7cfc2d9bd8f9@redhat.com>
Date: Thu, 6 Aug 2026 06:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: warn about hunks which only add blank lines
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260731134046.1015479-1-den@openvz.org>
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
In-Reply-To: <20260731134046.1015479-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

On 31/07/2026 15.40, Denis V. Lunev wrote:
> Patches sometimes carry a hunk whose entire content is one or two
> added blank lines. It changes nothing, it makes the diff longer and
> it survives review because nobody looks twice at a blank line. The
> blank line itself is perfectly fine, the gratuitous hunk is not.

Well, I wouldn't say that the blank line itself is fine. It depends.
In source code, there normally should not be more than one empty line 
between code blocks, that's why I complained to the patch in your pull request.

Anyway, thanks for tackling this! But looking at the checkpatch.pl script in 
the Linux kernel, they added a slightly different check in the course of time:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=365dd4eaafa22d2c79913d5f057d636e8842c470

Maybe we should adapt that one, to avoid that the scripts diverge even further?

  Thomas


