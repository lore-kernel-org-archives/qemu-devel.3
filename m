Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E504EEE020D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soG8d-00014a-Pd; Wed, 11 Sep 2024 01:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1soG8c-0000u9-AT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1soG8Z-0005gf-M7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726033410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UK8H6r4Odw9reV2osCokRRcXZu0cJO2gIJAD0UxlifQ=;
 b=evyHXgkiG/jD5ZxS2OBHTp+HfvtppQjEUgs8ow5ihLug3fBzds4eWqY2BYU8nQhlE9vtim
 pJt5CLPhWFnyLPt3rVdCsBRxRH+ZUz8vYSwgzU6r4LWXdHWYDsFwvDOUYCS2qWC5tYYJZI
 DSMQ4tzxe1gEeI5MKYj/jbcHecA+f1M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-b9PJ_HnzN0C4ggXxpJHj3Q-1; Wed, 11 Sep 2024 01:43:29 -0400
X-MC-Unique: b9PJ_HnzN0C4ggXxpJHj3Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c25c45afb2so4527083a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 22:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726033408; x=1726638208;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UK8H6r4Odw9reV2osCokRRcXZu0cJO2gIJAD0UxlifQ=;
 b=HtbbcUCm6vduATA+4ikTXUoMp7qwgqlBSUT6U1iUuyaLv/Kc6uDJ/JdLqgBJoktuP8
 EM4fAum4dEM472cdxGnV861w4j3rnoeOHgadc2dvxiLo9sA87MtYn7jh9LpKbVp0q0ba
 Lsij3LdQW6MZDS+ogr1g1hLN6wen9w/oy8SseLU903VF5LBBPbiaDoF53NUB+kL5RuwT
 goBWi2jt7T/vbT4xNLzMPpCDAU8HmMjH0aqmnxsMwHmvQfKlI8OsFy8Dhk/OuIWT3gBB
 6Dn0gjsf++D7bNy3fA3EQJYbC1oDffFCPB5OsdyFprJsracqNFrkq2ArGgauQzbv3ObD
 6EbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH2LAHPn2o6Mg5B00VtWeOHKdBt8VeBjcTsxZtzUeNaqtFFcnb8fQijeBsOQ4kaleLnKxfskI6XWbv@nongnu.org
X-Gm-Message-State: AOJu0Yw7XJSnuC7eZHyxlVx6wBwblf/DxilO+zmUh8o4Pz1G/svq+ril
 FbpwbL4AjElK40xrTE6t7drlp879dyRbvBEX8K95rjiqNFFRsL4IZEJ9vYPQf1dEVt7KWa4F7Uv
 /Y4MJowL0U4lByu/zf/qpakFrJYC62CJN62RR4fw0PswHWYw1KFQo
X-Received: by 2002:a05:6402:378c:b0:5c2:75d3:fbf7 with SMTP id
 4fb4d7f45d1cf-5c3dc798350mr13364142a12.14.1726033408363; 
 Tue, 10 Sep 2024 22:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc5MZwcQRT3DXtntJPztRAM0mTBwU5yIMlVJi/Gh2eKdIUBMZDznADRg/tKPcERJPo77P+jw==
X-Received: by 2002:a05:6402:378c:b0:5c2:75d3:fbf7 with SMTP id
 4fb4d7f45d1cf-5c3dc798350mr13364077a12.14.1726033407732; 
 Tue, 10 Sep 2024 22:43:27 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-122.web.vodafone.de.
 [109.43.178.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76f32sm4983417a12.73.2024.09.10.22.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 22:43:27 -0700 (PDT)
Message-ID: <19273472-164f-4128-ae31-46c79b9e20c9@redhat.com>
Date: Wed, 11 Sep 2024 07:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/39] tests/qtest: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Keith Busch <kbusch@kernel.org>, WANG Xuerui <git@xen0n.name>,
 Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-13-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20240910221606.1817478-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/09/2024 00.15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/qtest/ipmi-bt-test.c  | 2 +-
>   tests/qtest/ipmi-kcs-test.c | 4 ++--
>   tests/qtest/rtl8139-test.c  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/ipmi-bt-test.c b/tests/qtest/ipmi-bt-test.c
> index 383239bcd48..13f7c841f59 100644
> --- a/tests/qtest/ipmi-bt-test.c
> +++ b/tests/qtest/ipmi-bt-test.c
> @@ -251,7 +251,7 @@ static void emu_msg_handler(void)
>           msg[msg_len++] = 0xa0;
>           write_emu_msg(msg, msg_len);
>       } else {
> -        g_assert(0);
> +        g_assert_not_reached();
>       }
>   }
>   
> diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c
> index afc24dd3e46..3186c6ad64b 100644
> --- a/tests/qtest/ipmi-kcs-test.c
> +++ b/tests/qtest/ipmi-kcs-test.c
> @@ -145,7 +145,7 @@ static void kcs_cmd(uint8_t *cmd, unsigned int cmd_len,
>           break;
>   
>       default:
> -        g_assert(0);
> +        g_assert_not_reached();
>       }
>       *rsp_len = j;
>   }
> @@ -184,7 +184,7 @@ static void kcs_abort(uint8_t *cmd, unsigned int cmd_len,
>           break;
>   
>       default:
> -        g_assert(0);
> +        g_assert_not_reached();
>       }
>   
>       /* Start the abort here */
> diff --git a/tests/qtest/rtl8139-test.c b/tests/qtest/rtl8139-test.c
> index eedf90f65af..55f671f2f59 100644
> --- a/tests/qtest/rtl8139-test.c
> +++ b/tests/qtest/rtl8139-test.c
> @@ -65,7 +65,7 @@ PORT(IntrMask, w, 0x3c)
>   PORT(IntrStatus, w, 0x3E)
>   PORT(TimerInt, l, 0x54)
>   
> -#define fatal(...) do { g_test_message(__VA_ARGS__); g_assert(0); } while (0)
> +#define fatal(...) do { g_test_message(__VA_ARGS__); g_assert_not_reached(); } while (0)
>   
>   static void test_timer(void)
>   {

Reviewed-by: Thomas Huth <thuth@redhat.com>


