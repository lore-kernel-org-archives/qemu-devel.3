Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833FCCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5oBo-0003oY-Sl; Mon, 06 Oct 2025 12:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5oBl-0003o7-Gw
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5oBd-0006EF-Pa
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759768537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g8UmADwGZt4WwB1r5YYKVvComf/A7LG/bJTcdUjhw+0=;
 b=dLk5O3irkhbbN9ZD+WDcWfzflttCHxWuR42lhKjVHe9Ku1fCIOjJA5FJpXLb+LR69ckjPF
 b43xbo861XveEaV5iFRWxY+GvhmYLmMBqBKp25MoPJmjKdc8BGeZ22QHVg+juPS+QryNWx
 rt3xZEC9s5+kn5hNPUs8Jo/Ul94pfac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-E06dN04yNQa5tFjXBe_iuw-1; Mon, 06 Oct 2025 12:35:35 -0400
X-MC-Unique: E06dN04yNQa5tFjXBe_iuw-1
X-Mimecast-MFC-AGG-ID: E06dN04yNQa5tFjXBe_iuw_1759768535
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so3715319f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 09:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759768534; x=1760373334;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8UmADwGZt4WwB1r5YYKVvComf/A7LG/bJTcdUjhw+0=;
 b=Mt9y+QB96PB58DWnXzx0/OD7KW3QeuVsUcUbFqz51hYNgwJpZK7mHrP+L3IEBXl6/j
 7HQMET1tygJrzSQkrrasmQMDgtFMxbZy/Ue1AF9OeZ0RkLW7gOE/xIHsQ5dt39/uYLDP
 8opatzrARpjOlGr5+DjAJ9M0cjRCm3dtU7+klxN4WZZPkzY9Qvzo5pmQj10Bn+SApyD5
 j43WtU9Xg/lSkYwMNxa7CYksMPBSs3Rl8sXZwAoa0UFmRSG1i1HwrBqH07xasE7I0l5f
 mdMN8bjBAhg6fFQ0szkBWNkhaYAHHgDDUc9L767jAf4UrkMY82fiTt9mI5oiYl2baiPK
 ayKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOsM0/3ZsXb0Uls7f9E0lUOCUgNeK/hdDrq353j/8f6RYo+iyIzTMQxojqDwiAKXnLBf8/TouUKCz7@nongnu.org
X-Gm-Message-State: AOJu0YxOv05b3YBeTLgLYX95c30VH0m8JofM4Hwr+GeKerAmHsHB3rcd
 XoKwaaVKJhF73UZMtBDVJp3JLv1h1uwwj/pkLcV0edocZ0OjBSOBLdCQF7YbxmAEbP8oGcFKZGN
 l9CTiIO2T4rMvd9r0gv+iXpOzhLjwySDZu7yRwv6y1hm4IOpTUa1E3hRO
X-Gm-Gg: ASbGnct8B5Q1vxklG/Pf95ePFH1KI/rvhIU9Z+Nf6PFHKy2CTUPNbaPsEGk5Da5SL5W
 JZ42qiabbAu3sCRfEaOTQRm3rGnd0+UdJvaN1NUnTaRr6K4/IpgEgAEG5GTOxFxo0503LCKl2ub
 VnrC5ptfCXjFIV+dDBlftN0d3hEc9eEvtd4GL4dzbaXuRrinuGf5An1vfSyvoYDtpBrLVYqO5tS
 Xnbzi0zm4UZtCqctymMmGkH+wwFtz+dCKYwfEXUbfceJDLXOwuPlqu5GgAgopuCJtt5rcrZpADk
 n/v88Z53jw6isP35H5c8u0lVDZuh+Fbua7PlcvLExEtdvhrl1+Bea1QhCdBAUZ3+AfBodKj4Ybk
 4yNW6aiSXDg==
X-Received: by 2002:a5d:5d87:0:b0:3f1:ee44:8c00 with SMTP id
 ffacd0b85a97d-4256713ea65mr9485209f8f.10.1759768534601; 
 Mon, 06 Oct 2025 09:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8zQRMdM5nWONq1k0x72gkVJLy106H/T69jRmowuqPd2OEuDkpvlK+VFU4TZo9yqrWNgVsgA==
X-Received: by 2002:a5d:5d87:0:b0:3f1:ee44:8c00 with SMTP id
 ffacd0b85a97d-4256713ea65mr9485188f8f.10.1759768534112; 
 Mon, 06 Oct 2025 09:35:34 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ac750sm21790601f8f.24.2025.10.06.09.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 09:35:33 -0700 (PDT)
Message-ID: <12c11d52-b1f6-490d-bc0e-94cf0dc3b66b@redhat.com>
Date: Mon, 6 Oct 2025 18:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/23] tests/functional/aspeed: Add to test vbootrom for
 AST2700
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250505090635.778785-1-clg@redhat.com>
 <20250505090635.778785-13-clg@redhat.com>
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
In-Reply-To: <20250505090635.778785-13-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 05/05/2025 11.06, Cédric Le Goater wrote:
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Add the AST2700 functional test to boot using the vbootrom image
> instead of manually loading boot components with -device loader.
> The boot ROM binary is now passed via the
> -bios option, using the image located in pc-bios/ast27x0_bootrom.bin.
...
> @@ -110,5 +127,14 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
>           self.verify_openbmc_boot_and_login('ast2700-default')
>           self.do_ast2700_i2c_test()
>   
> +    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_06(self):
> +        self.set_machine('ast2700a1-evb')
> +
> +        self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
> +        self.start_ast2700_test_vbootrom('ast2700-default')
> +        self.verify_vbootrom_firmware_flow()
> +        self.verify_openbmc_boot_and_login('ast2700-default')
> +        self.do_ast2700_i2c_test()

  Hi,

just a question / idea: The ast2700 test is now one of the longest running 
aarch64 tests ... would it maybe be ok to drop (or disable by default) the 
test_aarch64_ast2700a1_evb_sdk_v09_06 test now that the vbootrom test has 
been added? Or do we really get a lot of additional test coverage (that we 
don't get by the a0 test yet) by booting Linux twice on the a1 machine here?

  Thanks,
   Thomas


