Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7785FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEO3D-0008Fi-QM; Thu, 30 Oct 2025 04:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO39-0008Di-TL
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO33-0005Gd-9T
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761813016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mQON9S8HA6JKbFMviDz3n6JvHKmQgUkfE7L3JghWZNM=;
 b=YxofZfcIiSxHOXbW0wqZ3jFUQ+A5gOFJWKRznrz/IF09mqWNNVvNw+suQUo5KEPrNAs+HP
 oKyZ3t8S3qMovWt38v+MFHwDTG7ZyNqKpDMoKMFkqUvzL0DN+y/k2OAg1TQ6BJW4E74Lnx
 Sd/CSGZRvyLtTYa/9FCNYWIkbLmHoOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ml-Pz5U5Mo-3-Io-wKN_uw-1; Thu, 30 Oct 2025 04:30:12 -0400
X-MC-Unique: ml-Pz5U5Mo-3-Io-wKN_uw-1
X-Mimecast-MFC-AGG-ID: ml-Pz5U5Mo-3-Io-wKN_uw_1761813011
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-427015f63faso414525f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761813011; x=1762417811;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQON9S8HA6JKbFMviDz3n6JvHKmQgUkfE7L3JghWZNM=;
 b=xAj2LNmbOqHAZyEj1xJ0GvEr/huTYL36IYzSiZS67ngbyDEzpF2UvyB3VzExh6zIuv
 gGTS3Vq6hWFDlXzHsUnOApToI/O3eUOsTqmSH/McdbJ7vE4rrGuNsMy0ztRxxdaaojAd
 sVoY34KglqBlodTZgN9sSAPh+wZEe6IyVVvPFIeZyEwJYgZWtpHqYyJi3F5I7ISuQEc6
 z744w1lLKGckaixmPq5q/APtX45Yk4RLb4LtJFKr5NjYWdJZCCib58baBRgv5foKxcF4
 hv1EqqmCFrAa/psC7sPFI8D1rGBlauKNH2PWH/TLta8zYBv3pHQY45kh8tF0iUQ8ch8h
 6K0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHH6Z3Wf3FMblDLGMf87tXfV49UalXvIZPf80izxa01AsSOFy5gQjn8Uluqouve9DPlKsa1aM/5lAE@nongnu.org
X-Gm-Message-State: AOJu0Ywbvxy/+JdYYf2VRruRVbJ0RiUGvwwFlY3bWnit3TAp7oAsVsnl
 lKhho5BLijVUM1k95fZzqDsYAHN0WAafGMGsFtCO6T+ETL2IjtL3FRfu8HCL8PK8Zahp9Pmsdxj
 PGN/dKnRmnA/agdOLZESdGmajDcZPo0U9SGWyi+zuGrR04dp4grkGscE3
X-Gm-Gg: ASbGncvPnFsqGimwdFZ4d22ti924rpDEIoXGIAVlMpr2CbIuxvdhe3p2e6Cpr3AWxzn
 GSIKWdCNWqPdo1p0JSqak5uaYJo7R02w6DYMKGsUXuiV90xunD0ZD98fESKj4bXPAegM7Z0amet
 Je6xk4hAiweMXW4zD9J3Vqxr+rkbFhvysj6IR9nwTwiw3116P2H92jAzxs2ds8OkeI8ad4/Bz/5
 rvnit1KsbfYfwhktZ/qW7KRDlbcIz8bPTNgzrnDTtVWlHWWB/vZh2OV6Axj1U02zWTWa2NKOUs9
 OOMg1NcwdIzePTCCiCtXsqsEj8Po/g4gyeX6LZD0eenp7/AbTqeJMuLYUaFrwk1j7x2bcHU=
X-Received: by 2002:a5d:64c5:0:b0:426:d80c:2759 with SMTP id
 ffacd0b85a97d-429aef82f47mr4885510f8f.25.1761813011214; 
 Thu, 30 Oct 2025 01:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoUC6bUe3NxZ/vAYQDgNfVowszSKOf5vad0KJBIQBrv2pA4CRHIAwfIhzRCQThMioA1QfFOQ==
X-Received: by 2002:a5d:64c5:0:b0:426:d80c:2759 with SMTP id
 ffacd0b85a97d-429aef82f47mr4885473f8f.25.1761813010783; 
 Thu, 30 Oct 2025 01:30:10 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb55asm30854722f8f.17.2025.10.30.01.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:30:10 -0700 (PDT)
Message-ID: <3727d68c-ca7f-45f0-af74-b695cc88afdb@redhat.com>
Date: Thu, 30 Oct 2025 09:30:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/10] python/mkvenv: rename 'testdeps' to 'functests'
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-6-jsnow@redhat.com>
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
In-Reply-To: <20251028220342.1407883-6-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/10/2025 23.03, John Snow wrote:
> pygdmi is only needed for functional tests and not tests in general; to
> prepare for more universally required test dependencies, rename this
> dependency group "functests" instead.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml        | 2 +-
>   tests/Makefile.include | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index daf5a18989a..3d6907af799 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -31,6 +31,6 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
>   sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
> -[testdeps]
> +[functests]
>   qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
>   pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d4dfbf3716d..6f86eb283d3 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -98,7 +98,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>   
>   $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
>   	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> -	$(MKVENV_ENSUREGROUP) $< testdeps
> +	$(MKVENV_ENSUREGROUP) $< functests
>   	$(call quiet-command, touch $@)
>   
>   check-venv: $(TESTS_VENV_TOKEN)

Reviewed-by: Thomas Huth <thuth@redhat.com>


