Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD96CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp2j-0004eG-85; Mon, 20 Oct 2025 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vAp2f-0004dd-1G
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vAp2X-0008Hg-JG
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760963456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RI4dd7AIHMXCfTGJcg9k9ZqCKZn2auOivMSsO+6ULqs=;
 b=Jm9zMzfPhPe7poTSzQasO5/WpmJipFEGfFqPyAEK4FLzcWkceGAMChCigdkEl0P3mCA/cs
 nfY0ol0aUyw/n5LBHm2iMlY7GwxH2cbvNlDkar/vHfbe9WbFku2pGKIYUQWHCBzwke/Gvw
 6Yf7SEKJdurl7eLbe5xecMoxo+/6jF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-V9aQGLMmNzqVln95ZaUYRw-1; Mon, 20 Oct 2025 08:30:54 -0400
X-MC-Unique: V9aQGLMmNzqVln95ZaUYRw-1
X-Mimecast-MFC-AGG-ID: V9aQGLMmNzqVln95ZaUYRw_1760963454
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4711899ab0aso33103365e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760963454; x=1761568254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI4dd7AIHMXCfTGJcg9k9ZqCKZn2auOivMSsO+6ULqs=;
 b=f+YAfLLVTGEwZgNkryIsX8kkJiwQrut7FXnhG4Cp6iP+cr1DkaHTRlRGXMLoVria/q
 uwVQkJxFV9ehOfJZ/E9ZmegRZOik1rwKUJ4h0Z2EXsotv8cSRghhsnoguq6uLpVmxKHJ
 ySjGBdMuaQQ++eq/Hx0uZV1wvAYOR5uhSj8mxJmZPbqiI4vzMoSCPMm7sXX5F8/MDiS5
 EyGR1j81Lc8767mOiumP2B2B6Eey1vdGDKZV7hIMvwsNgwh8HnwbwiDSt5L8O9cT1ZdW
 WHe3bpThjsS4FNYQejuRkmu3g0Vt4N6x0hM2TuaperHtbqE8NpjJiSqZ90UP1keswvDu
 xwhQ==
X-Gm-Message-State: AOJu0YyyJC/yx3RWPd7W4xvjY0z/EYOlLLcDYOo+uDrMZY14oy3R5zh4
 GTHtgZjEm4CZVstFFNfblhwd33CWCggA5W1/pzgpQ4yiI2qa0PY/zLjMQI4vBuGjZLtjVe0zatG
 /Rz7cfh6d3ZMXc52nuLOT2GivY1gvIzlABI5pccc1kbcCctT6miIZYXqO
X-Gm-Gg: ASbGncv3oZE4LpTssQw4a1oVToWJX/QWV/bb+dzIsJgLDT7S3JZDIT4ZhIJz4OCTu69
 tLLgyOjeg4BahU0WIOMjREP8sBto1BAeM+mJ+04a3uqVF6g7LtRFjMRO8pi7AN48jrQEuYG//bp
 VCc6nPenHaj2HTKlJPohNeedIdTIDlomsrdndqv3P+jDEBEJlGtBjsf6x4ml3Wvjk51qcBv2Nwp
 z8VFj3ZrJTkNzAMDqtN3zpirxd25bqFvkLjVIm22n+XtrBA7ldN16dth4vzazmphcSiAGmlDwCO
 dlLTxUCDVOMkluL/bdteX+/HFqb53zH+n9PONCnzAD+8VpOTUMwGZaM0+zqYBYnNXDeORXyKLyV
 R79lp8pnwCAIQC+Fl8vyCGfx/Z3NAYsAONFsIU/ourutdeYOnbUE=
X-Received: by 2002:a05:600c:34d0:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-47117911751mr102399025e9.28.1760963453681; 
 Mon, 20 Oct 2025 05:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv2ZtqSrkTWxeuC6C4lKG4PI8hvYBvsaL+lZW7S48uUkf3LY4n+V2SMnisGsG42UC9LjC37g==
X-Received: by 2002:a05:600c:34d0:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-47117911751mr102398785e9.28.1760963453073; 
 Mon, 20 Oct 2025 05:30:53 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm15298440f8f.9.2025.10.20.05.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 05:30:52 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:30:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 4/5] igvm: track memory regions created
Message-ID: <5njcwudlwuzeabxcwp3ns2khvfwx5pb6ldeonbppzpsqmu34qy@o7ortorjzcdh>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-5-kraxel@redhat.com>
 <jef63vhoedtg6l6l2luiyo7wpfdolewdpuzhfmxc6p2ek7u4w2@vbrhzyw67rg5>
 <ntzigwnexbqg4hmlqyuucipv6gw7o2xkqanpfdrwi3ydff3a3z@lrr3xwf4x6vw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ntzigwnexbqg4hmlqyuucipv6gw7o2xkqanpfdrwi3ydff3a3z@lrr3xwf4x6vw>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 20, 2025 at 02:14:00PM +0200, Gerd Hoffmann wrote:
>On Fri, Oct 17, 2025 at 03:58:53PM +0200, Stefano Garzarella wrote:
>> On Wed, Oct 15, 2025 at 01:23:41PM +0200, Gerd Hoffmann wrote:
>> > Keep a linked list of the memory regions created by igvm.
>>
>> Sorry, my knowledge of MemoryRegions is limited, but why do we need to do
>> this if we never access the list?
>> To keep references to regions?
>
>Keep track of the things we have created, so we can clean them up
>properly.  Which is indeed not needed in this patch, but we will
>probably need that in the future for the bring-your-own-firmware
>project (aka reboot guest with new IGVM image).

I see, so perhaps it makes sense to add this to the description, or 
postpone the patch until it is needed (not a strong opinion, but I'm not 
a fan of having code that isn't used).

Thanks,
Stefano


