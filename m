Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF048CFD658
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdW5p-0002k1-6N; Wed, 07 Jan 2026 11:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdW5m-0002hM-E9
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdW5h-0004MH-In
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767802135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QOdm1HQouhzZyt6PjiAAklb0P/Uzz1cUWuZ3p2SKeuM=;
 b=JgnQ6CvRgV8gjZmJTtbOJ/GyB9uFgJtzsBHhAdnFyk2k/El3OWzg1tzx2MkuK7nUABQQVj
 JyjdgqvNNmpxXyDCi4pq8QTYqZ0ihDeZnahYPehMvJ2/35nx5iFnpMZqrrddUD6FHWBQPN
 M7KU//vtQBXNP+s5rJ90LkGDr+aESms=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-3GScWi5PMI-FycaEHz6-ug-1; Wed, 07 Jan 2026 11:08:54 -0500
X-MC-Unique: 3GScWi5PMI-FycaEHz6-ug-1
X-Mimecast-MFC-AGG-ID: 3GScWi5PMI-FycaEHz6-ug_1767802133
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b841fc79f3eso225716566b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767802133; x=1768406933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QOdm1HQouhzZyt6PjiAAklb0P/Uzz1cUWuZ3p2SKeuM=;
 b=IMHXVMMTBISHN6z+YUVquV7J3ZClW9unnpw9GFnbuCLeJ8rAwqLVmqNoVDw/kMp1yA
 PZKH/2liyJbFfe0hZFnhY72kH1V3+9sEJM38sE1NHqZKnAkjqxmmJ0AsiBlLt4yMhY0y
 /NSiA7oFW8BmrwBbnKW4lUZUqNfAp2KIdgFMgUN7w81elIv13KfsGAbBPmckEHfCwzhx
 J6K1Ck0ex2gDDhYvsE3dGzlOlokC06CuFt1zRXR8cibK7ZJzajk46+T9KU7Wvrw2UoDy
 3SHaUs24VROZkwGdrfVOv6wh8BFRExyjDb/D5pI0GeS9ysQkaDkCPhbnYgI69Piye+16
 bPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802133; x=1768406933;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOdm1HQouhzZyt6PjiAAklb0P/Uzz1cUWuZ3p2SKeuM=;
 b=gr4TwXWZ1F7tBRsknG14ez6Wy91dyLhxtjkCBV6BsgdBqOc/6ItwyC3M2JN8D1ZXRb
 0cPL7cYduTZHUMcQJ9PopwuozFoWLZZubMsqGEDUsX2ZEaf5LJZIjupKWhzorIrGhABz
 nS7czWHPiSDtA47WAE7p/vg2xB2fcwgvmmXNBKMbCZWxzHZZxY4cVXx/uve3ivUXMf3X
 O76Bgkoz64EHErL8DBpRPHj2z+z5uCuiuQobTDDPQshoHtn8b053rI1DnaVxsxNOCJxn
 ly2CHqvYUTaGokBfCFbDIF5qEW20+r5iJm61ejHdijMgrVTPLQLF9PPHd149nYqGCpQ5
 yl7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUshOepfLQfjDcUsuDA3M5oKGn1lwMwSALcm3HC3Dyvwk4eVlJju+UaxAMLhxL0IvqwKK6Q512Utjgl@nongnu.org
X-Gm-Message-State: AOJu0YysmVYj1NIpJ5cpja+1aBJmtIcAeyibtlGgeXBY7ybempy8qDSC
 mo5CfjVssNKEb/Gby+BtlG3EmNvCBMOMgTy/WOyRdPdWZcT1p+4WSibJnx8ol6BYnR25KBL3sxJ
 vkAxwq8bEu+HaMkBY/aNMQXSKuOIuBnekp6DuZgiM9AqRIYX5crNrKn63
X-Gm-Gg: AY/fxX4puLDDVf/69LM+uquqpoebzU7RoRG0irYclFpxU5yoNoEPvdi7e37az7bBE2W
 FQp5AFJzCRLN4h+cRTI0+jurH8iGuQByy0baxWhd/hWdSxB+2rlt0Es726Q9r93saBwnmraR3IB
 ghq/8feM85J81MHU+BfnOM2If/W6judOQoE2NPKxKkxNNittOECw9EExlYPk/4HU3s8arKl6/fz
 Op+hDVUulVETLUcoIOYhIzzqYRO1tLFtDmo1wqAjF+CTVlL55ov73Y/XWsW/Go1gMBDnJHh5WsG
 OP4ax+Pnq+w4GhxMkwC4rbh8prTuBIiN2rO+QVMB5x3VGlr5Q1QCi21HloAAInsaAkOYLh0vVh3
 3Ayty8sR/PL6oBmO62fKgn46zwHELgMwsl3g=
X-Received: by 2002:a17:907:fd15:b0:b73:8cea:62bb with SMTP id
 a640c23a62f3a-b844532bb1amr313954566b.31.1767802132967; 
 Wed, 07 Jan 2026 08:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEiLLt6AI6bJwwttCDvhMEWY8fGW37KWHWk5dJ4nMH2PsgfvRTdRn121Bm2qzeJh4HvLj/DQ==
X-Received: by 2002:a17:907:fd15:b0:b73:8cea:62bb with SMTP id
 a640c23a62f3a-b844532bb1amr313950466b.31.1767802132388; 
 Wed, 07 Jan 2026 08:08:52 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b9d508csm5768712a12.13.2026.01.07.08.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 08:08:51 -0800 (PST)
Message-ID: <1c7f4a33-b730-4668-9a3c-948d47203ab1@redhat.com>
Date: Wed, 7 Jan 2026 17:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
From: Thomas Huth <thuth@redhat.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-8-jrossi@linux.ibm.com>
 <386824c5-d0f9-4384-a4de-d2ff5a3445d7@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <386824c5-d0f9-4384-a4de-d2ff5a3445d7@redhat.com>
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

On 07/01/2026 15.44, Thomas Huth wrote:
> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Enable virt-queue PCI configuration and add routines for virtio-blk-pci 
>> devices.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
...
>> +static int virtio_pci_set_gfeatures(VDev *vdev)
>> +{
>> +    int rc;
>> +
>> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GFSELECT,
>> +                           c_cap.bar, 0);
>> +
>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
>> +                            c_cap.bar, vdev->guest_features[1]);
>> +
>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_GFSELECT,
>> +                            c_cap.bar, 1);
>> +
>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
>> +                                c_cap.bar, vdev->guest_features[0]);
>> +
>> +    if (rc) {
>> +        puts("Failed to set PCI feature bits");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int virtio_pci_get_blk_config(VDev *vdev)
>> +{
>> +    return pci_read_flex(vdev->pci_fh, d_cap.off, d_cap.bar, &vdev- 
>> >config.blk,
>> +                         sizeof(VirtioBlkConfig));
> 
> I'm a little bit surprised that there does not seem to be any endianess 
> swapping for the config.blk data anywhere here ... isn't that config space 
> data supposed to be in little endian?
> 
> ... oh, wait, you're not negotiating VIRTIO_F_VERSION_1, are you? ... so the 
> config space is still in big endian for legacy virtio? ... hmm, I guess it's 
> ok for now, but in the long run, I think we should rather use VERSION_1 
> instead.
Thinking about this twice, could you please have a try to use 
VIRTIO_F_VERSION_1 right from the start? I already heard from some people 
that they'd rather want to get rid of legacy virtio in QEMU (e.g. for the 
universal binary project that includes multiple targets in a single QEMU 
binary), so I think it would be safer to immediately go with VERSION_1 here.

  Thanks,
   Thomas


