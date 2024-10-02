Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A963CF31B0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwoG-0003W8-2Z; Wed, 02 Oct 2024 06:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwoF-0003Vj-3e
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwoD-0002en-PN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=biPmuPpkrqekA6H9Bm40Z1QrtuWIvhatsbwVzg085u0=;
 b=OEhXTmxikSLwqpB9mwjK82CoASn02/ctdVPtEWsud2Lvixm/DlglBmy4OwfUslYsJuJv8D
 uNeRADFbxp+lipvkkv+rdbf86Vp8uDb3gn3b+QIlbaHICFbPyErstPiwXjavL8kzrnNNQN
 RUkiGe6rIfu3bGeJw6CNcE7HltKnZ7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-hhFO-RLaMJOA4sPJd90yBg-1; Wed, 02 Oct 2024 06:42:13 -0400
X-MC-Unique: hhFO-RLaMJOA4sPJd90yBg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42e611963c2so50124885e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865731; x=1728470531;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=biPmuPpkrqekA6H9Bm40Z1QrtuWIvhatsbwVzg085u0=;
 b=voBD+DRvUmabhqxZZ7kHTg4Wq5iGGsjI2U8tkanF0BLV7+SrXVlDP8IlrVwufO9mbo
 NmRzSiweqMIqbTJEVSnsysQ07wE+GOvGs1FhzYAXacUpdOjH4gFuYHLxSWEnsQegi8ne
 xBSa4t4Rw/pmzy/O2N4NxnCTMV45gZy7iriHxK5cL0LszXUzTT8pOdxxicyKwmB6wjPU
 LOp/nZNGQQ01MFlcJVreY0bXcQ8ZkFkYnsa2iOIBZfVoIHXI6OCELAa5Ut3+rjUZo6ha
 YyFQWywh8kMDjzqOSDez1uRa3u0Nnpsu49C9FyKPPjw9CGxb1F2EkC6WYyuV72v6CJNK
 xSFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIZbRl+6xkE1RXudqJMuG1T0rQWPvgc26qsghknJ0i6vpOp7dGE4vqmtj5iqRDO7l2NVFc6WK6ZtYD@nongnu.org
X-Gm-Message-State: AOJu0YwlcuquW1l7wcMXnhRcJudmptOSeQtSx4Oom61Rb4uvELlvl3V1
 jP0TZCM+MlNVLXwH3DYLOpOxcUBi5viHKTnNgDnwzPJjfs5sh57ogVPU2GBdqYS/hNbVcJnRM2X
 UtiJcyjQJg1ljFcEb9wPBlhcyv+RrzjRyHOTiPSTRqoQfx+trdC2W
X-Received: by 2002:a05:600c:1c98:b0:42c:bb41:a079 with SMTP id
 5b1f17b1804b1-42f777b631bmr21872395e9.1.1727865731597; 
 Wed, 02 Oct 2024 03:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhr+72AOrAx7SjYWAvmB1urrRChcFrMjz66oYhTp5MLgMsM7VSSHBAgba4OCyVghM71A/CFg==
X-Received: by 2002:a05:600c:1c98:b0:42c:bb41:a079 with SMTP id
 5b1f17b1804b1-42f777b631bmr21872135e9.1.1727865731157; 
 Wed, 02 Oct 2024 03:42:11 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a01fc92sm15113775e9.36.2024.10.02.03.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:42:10 -0700 (PDT)
Message-ID: <edeb3df1-1a73-4c8b-8870-866221f7a30b@redhat.com>
Date: Wed, 2 Oct 2024 12:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Remove unused pcie_chassis_find_slot
To: dave@treblig.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240918234748.468148-1-dave@treblig.org>
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
In-Reply-To: <20240918234748.468148-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 19/09/2024 01.47, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> pcie_chassis_find_slot has been unused since it was added.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/pci/pcie_port.c         | 10 ----------
>   include/hw/pci/pcie_port.h |  1 -
>   2 files changed, 11 deletions(-)
> 
> diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
> index 20ff2b39e8..9f978ba164 100644
> --- a/hw/pci/pcie_port.c
> +++ b/hw/pci/pcie_port.c
> @@ -92,16 +92,6 @@ static PCIESlot *pcie_chassis_find_slot_with_chassis(struct PCIEChassis *c,
>       return s;
>   }
>   
> -PCIESlot *pcie_chassis_find_slot(uint8_t chassis_number, uint16_t slot)
> -{
> -    struct PCIEChassis *c;
> -    c = pcie_chassis_find(chassis_number);
> -    if (!c) {
> -        return NULL;
> -    }
> -    return pcie_chassis_find_slot_with_chassis(c, slot);
> -}
> -
>   int pcie_chassis_add_slot(struct PCIESlot *slot)
>   {
>       struct PCIEChassis *c;
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 90e6cf45b8..7cd7af8cfa 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -72,7 +72,6 @@ struct PCIESlot {
>   };
>   
>   void pcie_chassis_create(uint8_t chassis_number);
> -PCIESlot *pcie_chassis_find_slot(uint8_t chassis, uint16_t slot);
>   int pcie_chassis_add_slot(struct PCIESlot *slot);
>   void pcie_chassis_del_slot(PCIESlot *s);
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


