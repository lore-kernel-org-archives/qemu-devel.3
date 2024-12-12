Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2DEE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLgzL-0006rI-2G; Thu, 12 Dec 2024 06:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLgzJ-0006qk-6E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLgzH-0002D4-17
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734001446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+huJ2rRnMvzg10tR+5I8BCXsMF5zVi+hXEuCB+vHFKw=;
 b=Z29FGGGwKk4eKvhOTKH9mHCGZpwaXqI/w9PpurbDxqzfodKSfpfwLWwoGX1m1HyV9oX60X
 ERDmcfq0QZl9cby56zVrexlf2n4fq512pI5fLTT/xnFRkXC/8wzLY6Mhs70IE0B9coD710
 DPNEmYr471fd7eIJkosiOnlDev+f0cw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-vrK0ebz-MaucLOkLwBkDVg-1; Thu, 12 Dec 2024 06:04:04 -0500
X-MC-Unique: vrK0ebz-MaucLOkLwBkDVg-1
X-Mimecast-MFC-AGG-ID: vrK0ebz-MaucLOkLwBkDVg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385dc37cb3eso279984f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 03:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734001443; x=1734606243;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+huJ2rRnMvzg10tR+5I8BCXsMF5zVi+hXEuCB+vHFKw=;
 b=GelPES7ktxKneByL1BBNXoy0csE4hj8tzGOGPZTEIzsUXAFM+ZGDWdCCXUBHlZO3NY
 PrdQ0cMcjot6dILq7SgC6B/zXOuZbPNTcBc3V82tAnMPubVKe+3o7vcbNupqmD3mTNgM
 cMQpyEcTATIIfGowAGGoEVomGC6tN/7k0qCFpiWMoxcpPyK1oMdB9k7IekfLUjOJ9Mxz
 UmHX8FZScxg+cKwRriV2ACkVb9wV7L8g+m3+RHqJ1GF1ePgvfc3V/ywJRWXP0rCMrCro
 VyAWB4AybydgVvflCBsk4qlOUMKhCRyGT8xKRrPuzPNbx5bfdnVD1rrWhsyOeMTudbua
 Haag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCVHJ/tktZiiVkPk86OyqKPodxIrqXqaNxRqT8Xya9ZofYkJrnNd9wrDHLWAZL19qT6u06w4QhA6lO@nongnu.org
X-Gm-Message-State: AOJu0YzKlaUp1QsAhsisDLzaz/IQPM01UWMtDwlgLKp1iuUpX/gB2rUo
 i3HanJ9cCj3Yu3AlAAQLX0E8EIRhM0DTw6fnArQMM++jTR86J0Ak3DOpXwiVSZlyBd1Xw8zO5cR
 Gc1wVRdPMuI3DHcDwEq4S7CA062+VTLHQ0tIJkmjL6FnmS4GtqCSu
X-Gm-Gg: ASbGncuGSdSrhqKwIDo8K/LJoY2AiA5qBrPhJA5+6EYZ7GkoNXf6W1hHPpCug4/cBD5
 gHHF4jaSGYBpRDiYf/mQCwMs4fi5/YNThjcHdcsLmmi2cvIXNyxRMmb8vcAgXrrt6ddhB1DLArl
 x58YfYqc4Kj8ZD/vCeigQU+RJMZd5OpZzAHGXrEl6xXl90GRh8nB41DggABpybf7Rl8HDXVbgrc
 iaFhE57eU+TVKoNCDW47QnYnaePr8svKlnpZvJH9e+FD05SBjAIc9KXZ9Ortf9vhppZrTWxILGB
 Qud4TA==
X-Received: by 2002:a05:6000:2a1:b0:385:e3cc:267c with SMTP id
 ffacd0b85a97d-387877dc758mr2085980f8f.56.1734001443468; 
 Thu, 12 Dec 2024 03:04:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGmGhMnN7FvPsgzZO7VlA8IoNlQ5Gc3zztB1vczRyipqycivoghNr70FZowHQGYa55DKmioQ==
X-Received: by 2002:a05:6000:2a1:b0:385:e3cc:267c with SMTP id
 ffacd0b85a97d-387877dc758mr2085959f8f.56.1734001443157; 
 Thu, 12 Dec 2024 03:04:03 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514dadsm3681284f8f.68.2024.12.12.03.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 03:04:02 -0800 (PST)
Message-ID: <45824f48-fee3-4220-927a-e72d0759392e@redhat.com>
Date: Thu, 12 Dec 2024 12:04:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/31] tests/functional: drop back compat imports from
 utils.py
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-28-berrange@redhat.com>
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
In-Reply-To: <20241211172648.2893097-28-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> Now that all tests are converted over to the higher level wrapper
> functions, the back compat imports from utils.py are redundant.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/utils.py | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> index 6b87af4414..43853b4366 100644
> --- a/tests/functional/qemu_test/utils.py
> +++ b/tests/functional/qemu_test/utils.py
> @@ -10,11 +10,6 @@
>   
>   import os
>   
> -from .archive import tar_extract as archive_extract
> -from .archive import cpio_extract
> -from .uncompress import gzip_uncompress
> -from .uncompress import lzma_uncompress
> -
>   """
>   Round up to next power of 2
>   """

Reviewed-by: Thomas Huth <thuth@redhat.com>


