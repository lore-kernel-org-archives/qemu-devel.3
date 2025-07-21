Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9812AC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udmCr-0007Jf-El; Mon, 21 Jul 2025 04:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udmCq-0007I0-0N
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udmCn-00031y-TR
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753087744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAufFh2LUgG5kuUETXc2PDqREMdWjxyDrjFB3zkP5f8=;
 b=NRLQbGMI4300E7gNp2Hjpl7CdYO6oUr6w3qzq9RjGZ/r8qoyTcRMfE67pvGtS4NHrp4jfA
 HzRI5u/aKj+HtNrLTF9cBFRUeKOa1lTF9OZ9HFNm7ao/xieW9eAk1e20DpJf/e3zWmQxa9
 3xYQJa1thvtV1xBd4MWynVYpIgCiHDo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-T2i78AtbOBeoDGhz845vUA-1; Mon, 21 Jul 2025 04:49:03 -0400
X-MC-Unique: T2i78AtbOBeoDGhz845vUA-1
X-Mimecast-MFC-AGG-ID: T2i78AtbOBeoDGhz845vUA_1753087742
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso1795111f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753087742; x=1753692542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UAufFh2LUgG5kuUETXc2PDqREMdWjxyDrjFB3zkP5f8=;
 b=DtHZljkvf+5N2/ZXo2apzaokVtOo3vP9rWuj76ZI8Bw2uflTBZVN4b0AcvR+uHzg+e
 X3IjOXxwdtnNxqDL6fx//BPPBLXFdFbiM3CtCVABRIlnUEZ7x3uMQhcZWLxoa33Waigg
 Guic2pp+1ffwl5cHA9reylda5gIAvljeNEiS1ou7adakMluIV2Q39ujcSBoTsDSt9kq0
 v8jnGDjl4mGI+cIIbv3BypbMkkkLRElvD338RuFSydB30cXseODAxWLHX6gFBx5vpiB9
 UdAfHz2tsjPasnmhViNr2YJqPG4aDOpTbc3PN0NX/1BBhqk2EMT/psAEVCFNrFE2SFHq
 SBMg==
X-Gm-Message-State: AOJu0YwT5iPysEfKImUIGWa1plLULCUyr+PMXAIwGoFrZmNCnNuAxB02
 iiiVcfWG9Gcl/ouL6DcQsjPowil7Van0HhoQ1GHfbERg+PYYCDqxVM+ny8ESEpp+9gI7Bfxw0iB
 TDC1a1dj3vS/HcSZzK2Ys4hwu8OLnMUWRUFhv4nE7TaZ9rxRQle1f8jnr
X-Gm-Gg: ASbGnctmMf3O2Za+eeDSzCenRpZ78DI0+Mn6C3+FrfPPEkUvnpo521XWNKSoqMJ+PWe
 nlONvXJTDXOJcu70VZxfZPxKzsgIs4XuWt6APgkYDqNF2wvkTaZBBhSKu08PB9dJShNftx4CRxj
 El71XLM2oBM1tskvLTftkUGQv4KNt4L6tJdYlAf3/5Rsxp4+P/KzC+t4n1Bl0S5veWemSQ/qUrn
 JrbRfMx0046DX6AxNjJCu/dSMb0XPqtbiLoEqpO1TQTCGsGyK6ELZLe181FhEjSPCbjZpasmg+5
 JJjSq/hEhU7Nmi39b9S56ltyznGrkqUiUb1w8h97LJ7XQ3u8f0j6Ng9/lxYN3krUiTqB/CjVWc6
 dvX8ku36C7ME=
X-Received: by 2002:adf:9cc7:0:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3b60e523b9dmr10846913f8f.53.1753087741581; 
 Mon, 21 Jul 2025 01:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNd7K+NflIIG/ssJcZH1UgiQUh2V52EesArq3pjYiQJe8MLnL1ju0DGxkn06Hx8AeYLqS6Nw==
X-Received: by 2002:adf:9cc7:0:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3b60e523b9dmr10846889f8f.53.1753087741117; 
 Mon, 21 Jul 2025 01:49:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4d73esm9579679f8f.66.2025.07.21.01.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:49:00 -0700 (PDT)
Message-ID: <3625d863-5609-4ffc-bf2f-68c122bf7c35@redhat.com>
Date: Mon, 21 Jul 2025 10:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 12/13] net: implement tunnel probing
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
 <y5qbg4bbp7horugws4wwpqtqcbff47gt2lksc7ookom5mplcm5@7eesso3jebep>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <y5qbg4bbp7horugws4wwpqtqcbff47gt2lksc7ookom5mplcm5@7eesso3jebep>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/18/25 1:17 PM, Stefano Garzarella wrote:
> On Fri, Jul 18, 2025 at 10:52:38AM +0200, Paolo Abeni wrote:
>> @@ -4245,6 +4274,14 @@ static const Property virtio_net_properties[] = {
>>                                   rss_data.specified_hash_types,
>>                                   VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
>>                                   ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_FEATURE("host_tunnel", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
>> +    DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
>> +    DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
>> +    DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),
> 
> IIUC, to avoid issue with live-migration, we should disable all of them
> in `hw_compat_10_0` in hw/core/machine.c (e.g. like `host_uso`, 
> `guest_uso*` in hw_compat_8_1).

I guess the relevant compat entry should be 10.1, right? AFAICS such
entry should added with a separate/specific before 10.1 will be tagged.
I'll add the relevant the entries after that the hw_compat_10_1 will be
added.

Thanks,

Paolo


