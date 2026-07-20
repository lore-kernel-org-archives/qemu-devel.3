Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD20C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlhHz-0001Zb-RE; Mon, 20 Jul 2026 02:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlhHt-0001XY-E3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 02:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlhHq-00040V-MP
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 02:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784528131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PQBILxtdgEs4nOOrJdR8dHr01yFPxc85CRnW0OBBSXg=;
 b=FQ5NYdsP87DS7ajqhesbBTTQ8ynqtvm0QkifxJgNc+qmka3m4EmbsK8kwc4SbE/qr7SBEj
 sQvVwA2l4eUb2CQGXwypjvuyX8LVlgCMjo9ByatJmPxK/emIMt/RNTXRFd4by7W8uICkNq
 UvCblhfN96M3PIoID/BJSIoWtFoAT+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-zIK9aUx0PsCRNq0f932_1g-1; Mon, 20 Jul 2026 02:15:29 -0400
X-MC-Unique: zIK9aUx0PsCRNq0f932_1g-1
X-Mimecast-MFC-AGG-ID: zIK9aUx0PsCRNq0f932_1g_1784528129
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-475e540a0ffso5521343f8f.3
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 23:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784528128; x=1785132928; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PQBILxtdgEs4nOOrJdR8dHr01yFPxc85CRnW0OBBSXg=;
 b=RbPDlgDJLeko6rWGufCIQ5vVzAhjHswOA3GvGDqxPOZ95Gb9mkPpOjjOrum12ta0h5
 3A8XPIu84adn9c3hbm+beGGfGJO1hAP+JxCfP4UVSxSduREYsAX0PPqugO2PoK7p7zpI
 4Pe5I7v7ttQUCMA2r9c8b8KlIZQlh3T8JpoxNWSol2VzjPv67+p2TrCfQ4JDGc6aafzP
 Fli7dzuTJtwVYodo2jas86GZnTKhPwqP7UMD0Wby4EGRdwaMlDRdALkbVAwlBw9+bVxf
 CPPWWHYCWRNUEKcW11psPy7VUhprNqsJTPOzvubRxUK7qsguDk5cwieRFE6LiN40SScj
 qOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784528128; x=1785132928;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PQBILxtdgEs4nOOrJdR8dHr01yFPxc85CRnW0OBBSXg=;
 b=GpddHrry30zAu+mBDOzn92U4XdG1tXAtrMJPtPylXwrNdpqrkDIC6sdOB/ca7GwBUz
 N51tmj7CbsI0rOptEZzfEF5gqeX2iy7DQ94Sp5BNH4RfKaim7QOi/U3BtzU7rUix2sf+
 Z+def3tq1hBKQ/+6gIsgde7fNH3YR2fLpRfS5/p0mSHiqEHnXD2LAuCdxhpXMebHllK4
 QvYppsQh74wEtemuqKEq6gyAMNZIf2mjTYxjCZEAdyl5oLIZlTVo5DhX58oDrOd2I9HN
 oVo1hMvRjcnfV1+tsj0H7b2akidjqKnK9BiFzWdkzA8DJbukQbQQV5BpJm49qyy2qmfk
 ycAA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6gtYhSYXVts8cC9Hg6UiR7yoNJKGM2Jn2I6Le/aMrOtXAZFBo8VFpJMslJrSkJOpaxVU6KlzGg9U5@nongnu.org
X-Gm-Message-State: AOJu0YysUO4AQ479pVWAAn2CCRYc31d3xEfhmrCqXlfeiVVapmo7rhBe
 K3HnzGykm0wwZ8fJ6xK3N8jFpgZZG4RrYFooSIgPm7l8uhHoFgKNPCDyHa7m4xrvSn+0+67a2vq
 /iPOt8r54BE5RJOWuxhRNUhYzf4/pnx+hUcxqnxXcouVrczB+E0dryvrP
X-Gm-Gg: AfdE7ckAxE2Fo/DvGHYME8IJWtqOnQWoji0oxVwU7ETisEwVViMDBXwLWUKnUmnm6mA
 mwtqixCTZg1h06V1Cs/mjBjsVGEmaCnmxHWk9LcsdjRxOtAUVpCjYXbxJb/D0mRdzCFhbRyzL6Y
 5F2dJ+NTVK712DDDke6Y2MClN11wRQ73uZI8L53fRzSg5WS1Kie078h6RotKJX0aa9tXCtzUAhB
 LjYLlloq1Gol5TwSwRtInJnDNUTNhsD1oFyLClEuSoE/0GO3tgqFkSld8CMQHItUlmkQzpbNkq0
 UGz5aRQvw6LdH/2nfBr8tRzkjyWzT26hCyK/tRqBRD7FifVRq1LhjYNOPOkt2yWnqjexS7EvoQ=
 =
X-Received: by 2002:a5d:5d84:0:b0:47f:56f7:7a57 with SMTP id
 ffacd0b85a97d-47f6232c4abmr15433802f8f.28.1784528128590; 
 Sun, 19 Jul 2026 23:15:28 -0700 (PDT)
X-Received: by 2002:a5d:5d84:0:b0:47f:56f7:7a57 with SMTP id
 ffacd0b85a97d-47f6232c4abmr15433748f8f.28.1784528128132; 
 Sun, 19 Jul 2026 23:15:28 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm30745181f8f.11.2026.07.19.23.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jul 2026 23:15:27 -0700 (PDT)
Message-ID: <1ce9ea25-bd59-47d1-bf26-9c5af0851dc9@redhat.com>
Date: Mon, 20 Jul 2026 08:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl: unregister vm_change_state handler and
 BHs on device exit (CVE-2026-63322)
To: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@mailo.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, qemu-stable@nongnu.org,
 Haotian Jiang <sundayjiang@tencent.com>
References: <20260720024855.3757499-1-jianghaotian.sunday@gmail.com>
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
In-Reply-To: <20260720024855.3757499-1-jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


Thanks for the patch! ... I've got a question below...

On 20/07/2026 04.48, jianghaotian.sunday@gmail.com wrote:
> From: Haotian Jiang <sundayjiang@tencent.com>
> 
> qxl_realize_common() registers a vm_change_state handler via
> qemu_add_vm_change_state_handler() and creates three bottom halves
> (update_irq, update_area_bh, cursor_bh), but none are ever cleaned up.
> The return value of qemu_add_vm_change_state_handler() is discarded, so
> the handler is never removed from the global list, and there is no
> PCIDeviceClass.exit callback to delete the BHs.
> 
> When a secondary QXL device (hotpluggable by default) is hot-unplugged
> via device_del, the PCIQXLDevice memory is freed but the vm_state
> handler and BH entries remain with dangling opaque pointers. On the
> next VM state change (stop/cont/migrate) or BH dispatch, the callback
> dereferences freed memory, causing a use-after-free.
> 
> Fix this by storing the VMChangeStateEntry returned by
> qemu_add_vm_change_state_handler() and adding a qxl_exit() callback
> that deletes the vm_state handler, all three BHs, and the
> guest_surfaces.cmds allocation before the device memory is freed.
> 
> Fixes: a19cbfb34642 ("spice: add qxl device")
> Fixes: CVE-2026-63322
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3607
> ---
>   hw/display/qxl.c | 15 ++++++++++++++-
>   hw/display/qxl.h |  1 +
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 74258afa58..c9323672a6 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2203,7 +2203,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>           error_report_err(err);
>       }
>   
> -    qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
> +    qxl->vmstate_handler =
> +        qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
>   
>       qxl->update_irq = qemu_bh_new_guarded(qxl_update_irq_bh, qxl,
>                                             &DEVICE(qxl)->mem_reentrancy_guard);
> @@ -2475,6 +2476,17 @@ static const Property qxl_properties[] = {
>           DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
>   };
>   
> +static void qxl_exit(PCIDevice *dev)
> +{
> +    PCIQXLDevice *qxl = PCI_QXL(dev);
> +
> +    g_clear_pointer(&qxl->vmstate_handler, qemu_del_vm_change_state_handler);
> +    g_clear_pointer(&qxl->update_irq, qemu_bh_delete);
> +    g_clear_pointer(&qxl->update_area_bh, qemu_bh_delete);
> +    g_clear_pointer(&qxl->ssd.cursor_bh, qemu_bh_delete);
> +    g_clear_pointer(&qxl->guest_surfaces.cmds, g_free);
> +}
> +
>   static void qxl_pci_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -2482,6 +2494,7 @@ static void qxl_pci_class_init(ObjectClass *klass, const void *data)
>   
>       k->vendor_id = REDHAT_PCI_VENDOR_ID;
>       k->device_id = QXL_DEVICE_ID_STABLE;
> +    k->exit = qxl_exit;
The resources are allocated during the realize() function of the qxl device, 
so not sure, but using the PCI->exit() function might be the wrong spot? 
Could you put the clean-up into a unrealize() function instead, i.e. add 
this via "k->unrealize = ..." in qxl_primary_class_init() and 
qxl_secondary_class_init() ?

Also, there are some more resources allocated in the realize() function, e.g. :

     qemu_mutex_init(&qxl->track_lock);
     qemu_mutex_init(&qxl->async_lock);
...
     qxl->guest_surfaces.cmds = g_new0(QXLPHYSICAL, qxl->ssd.num_surfaces);

Should these get deleted, too, to avoid leaking memory?

  Thomas


