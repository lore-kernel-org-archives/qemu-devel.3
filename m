Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A229BCCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhli-0000aa-NY; Fri, 16 Oct 2026 09:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xHhlc-0000a9-Qj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xHhlb-0006yi-4W
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792156474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cnO4Wg8vQU/yK/TG7plWtl6Ci/8TUrfJJ+HL0fgZK3k=;
 b=GnR4yR3VG1gVlb14WbxVHHCh6ux5ru+DgkToR4ObI//5LhL+GBrisXT/1PflOPfO2ddp5h
 ns9VfEK+my56GGvyJxfq/HXEYyqgIeBV7aKPQ9i9yvKnzKy3O7R0Fq/4AY5rvvU91q/VXd
 l7M/1pkggYCLp7FFUJtGCp3Yrqadi6A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-zmO3AG_AMbeF8J5zGO2mkw-1; Fri, 16 Oct 2026 13:14:32 +0000
X-MC-Unique: zmO3AG_AMbeF8J5zGO2mkw-1
X-Mimecast-MFC-AGG-ID: zmO3AG_AMbeF8J5zGO2mkw_1792156470
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-487038bc9b8so5141893f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792156470; x=1792761270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cnO4Wg8vQU/yK/TG7plWtl6Ci/8TUrfJJ+HL0fgZK3k=;
 b=e8QWYqmA1k4rHrnyUzpfL3yTIR5JlRhuL1xU4MMnrubexaj2m1ZmTA4X+DAX0lwgYI
 +3NJh/Q8hUuJX+KpO5s6RrJjyPZHdotxvohcsaxzVQSx3VTlaq9M5CDljSPjnDZwKP91
 LyfKPDG7RAkKjuHqF4rL/KNq/659AXAA1fFq1AQzF8WETdCLM9ZhbdYzz1OmdfoDFZd4
 B+G8pFHiBhVhfcdOpHan/4GoBWDQwPgo3I8uBUYXdc//weVXu8jmem3h2FbIZZ58nhsY
 UwnTfz+HKjuBX6Ynr+tV+BY6h+CaSZRI2CPLjNRwmlkUA+Xq7L2wKetYWUVvDDTMQIm+
 yVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792156470; x=1792761270;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cnO4Wg8vQU/yK/TG7plWtl6Ci/8TUrfJJ+HL0fgZK3k=;
 b=mQcJYdsOFd6b5KK2l9jw9gpa+k39RhjimceVbjtpj3UiAJNrwMhJl1uVbBQYtE79f/
 HECKKCWmZO4hDN4HD8HaGSEfG+kxbVL2W/LdEvFWjU1I6fy90Dv4gEWnOPvVSQqggF77
 k9aVktZyOqu2MwrwWizgvdGiFwesWlZrCV1Xlpc+OhfiLZ+kAePTz+R8jpuJuOeNR3nV
 3JI+0qqB5nnkJ6b9OVKPTXs/k5IKfIy5fVkrJFOwORjGCmsiLzhPNrfRmaxm+attAAO0
 dEScBPwg0PAD/ICRGrbJZuqa3SUYC+OCqTygle6zyZvrJrb8oaOV/qUti/on2jTaHu2i
 5qlw==
X-Gm-Message-State: AFq9FYI6Nphzv5Tv7jSQ/Cl5YVIM7FvJ24kGjrQdiuK8vVtEnTg5D0om
 UhBZ04U5bWUGpUs80Ji5ke2BjxFRZjK0JULVjHS/jWBgQV69snQbFoxW1Sc3pE/v30HErV+PoNp
 hrFGt+2mF16AUpiFWWyZbp9fhVqVYZdDRXljqrbxMKG3IZOBHyGOp9SZ4QNaLTWsf
X-Gm-Gg: AYBFou39ZhgENSW4l+EoNaVDC6f8+2ET3CyIyNXuLSegKEuFiArC3XlRO2a6OM1SHUK
 SLtXM83du4NsdoeXbuVnYHqmK1L6x3ezmSqTogWCc5X3xHakz2cDBPusFCxz8HGrHo/54r82gC+
 jZ357VtUNvNyYoIy/wZwS7rUJwGYuiptEiiu7lmTH/9i/3Y+/mf7SW5eMr5OR/IQuapAw5Yzq/Y
 oIbqHZf6rg70jPf0+WS3ySD8OpCmpj7xH6XgffVG6sLvSoCz47bM9t73E6gAS9bY4TlKgMw1EPX
 h7AmvVgWz1fz6nhRLHQX0wgja5lX56DIaUOKZu4buHzJ7rBPEPx91qNQ4eTpXZOi8o7rYLL68g=
 =
X-Received: by 2002:a5d:64ee:0:b0:48d:f877:3349 with SMTP id
 ffacd0b85a97d-48e019e9d97mr2618875f8f.42.1792156470406; 
 Fri, 16 Oct 2026 06:14:30 -0700 (PDT)
X-Received: by 2002:a5d:64ee:0:b0:48d:f877:3349 with SMTP id
 ffacd0b85a97d-48e019e9d97mr2618819f8f.42.1792156469979; 
 Fri, 16 Oct 2026 06:14:29 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503d78sm4805007f8f.50.2026.10.16.06.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 06:14:29 -0700 (PDT)
Message-ID: <1fa765e7-064a-4d50-bdb7-893e52557857@redhat.com>
Date: Fri, 16 Oct 2026 15:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] usb-host: fix use-after-free issues
To: "sundayjiang(sundayjiang)" <sundayjiang@tencent.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <tencent_05C1CBE16E1B8D920F523A75@qq.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <tencent_05C1CBE16E1B8D920F523A75@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/10/2026 09.37, sundayjiang(sundayjiang) wrote:
> Fix two independent use-after-free issues in the libusb usb-host
> backend.
> 
> The first patch frees USBHostRequest objects when
> libusb_submit_transfer() fails, preventing stale USBPacket pointers
> from remaining on the request queue.
> 
> The second patch deletes the lazily allocated bottom halves during
> device unrealize, preventing callbacks from accessing a freed
> USBHostDevice.
> 
> Tommaso Califano tested the original combined patch and reported that
> it looks correct.  This series splits the two fixes so that each change
> has its own logical scope and Fixes tag.
> 
> Haotian Jiang (2):
>    usb-host: free request on libusb submit failure
>    usb-host: delete bottom halves during unrealize
> 
>   hw/usb/host-libusb.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
Thanks for the fixes. I'll queue these for my next pull request.

But if you could do me a favor: The next time you send patches, please don't 
send them as mime-encoded e-mails. I had to apply these patches manually 
since "git am" refused to parse your mail. I.e. try to use "git send-email" 
the next time, this will make sure that your patches can be processed more 
easily. Thanks!

  Thomas


