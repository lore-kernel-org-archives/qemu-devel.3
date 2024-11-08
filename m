Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2523D5C0E5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Qhe-0004rV-EC; Fri, 08 Nov 2024 10:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t9Qhb-0004od-Ob
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t9QhZ-0001L5-Fn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731078907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sNBlREn3tuXExMWvXlvZWJk99FWN6ctsShBMeRHeiQI=;
 b=cZRHmYB837B8swZrm7AfeW4w2RuIu/plm+8h0ME00anMZEt0ifFVCl76qxqGcZhhcHhHdI
 ISjLe+k7PxJnFKQhHyT0ALAMlHUV/vt4fyNJEQNpj5WFZRn2P3E3wBoC7+vZ10k62Ts8hj
 XvpVJWjqWvnYG7MfgW5JJ1o1S+e/cv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-YmVc9hgdMIWDnbtft5Z8Gw-1; Fri, 08 Nov 2024 10:15:06 -0500
X-MC-Unique: YmVc9hgdMIWDnbtft5Z8Gw-1
X-Mimecast-MFC-AGG-ID: YmVc9hgdMIWDnbtft5Z8Gw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d462b64e3so1151345f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731078905; x=1731683705;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sNBlREn3tuXExMWvXlvZWJk99FWN6ctsShBMeRHeiQI=;
 b=ZfMRGLVyhgolY604H8TAd/LK+BtNJrq39ukJi1J8vOlmjK2zr5LFMJoN4iRQOUTHHZ
 P/WPTMtstjueoUnDBlN8MG4yEfdrW1PPROPNya/5PaVpYk38fZXf8xPd0jo/LRM+iBaC
 5Fk+PvMGz96AID//C6FbCsRI0lzOTPVrTGZp4S10OT1yWhyAoLEqe8a/P4UZ/ToclrPp
 aXd6dl+0e0rLF9pMYLbN89bcH0LAdqEe/ltHwMLJFoQuS4Tl3/Jsr7ZAH9FdovY3Pg2A
 cJqu3EQ43eFajCFtD/SR28OZWg31MjaU9rxRGBC4mETsuKvKZlk5vvL0IWQoLVmiG814
 iKxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNMaVb1RJRqgBe9og5318FKXRdm3N0J0OUiV5ry3zvNHepOupaSSwatNGgpkKmpn4D8NvUsYB/ugON@nongnu.org
X-Gm-Message-State: AOJu0YwDF6VAeLSolfmHxwQzleAuR8Iib0szdHK2qzIHj5SPk4yLKdO5
 +Ps5iwqeanlJvapmoiHe27uhY/kbu1VETghguJPWZ1gDDA1JB3wvK07OWd+sdPGaTYTFrS0vXim
 W/QsW9CiSvgecL+lvFLt6bSpla0p4LNhxhUsJV6LL/r6tJmQpp8ga
X-Received: by 2002:a5d:5f45:0:b0:37d:2ceb:ef92 with SMTP id
 ffacd0b85a97d-381f186bccamr2824760f8f.27.1731078905449; 
 Fri, 08 Nov 2024 07:15:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7QAoIPFMGldXpu1S8nTVAtaCQZd0b0DXvkHMNWoWNH9Q/QGkzZ2bWFabqIQbVE7A2OHqiDQ==
X-Received: by 2002:a5d:5f45:0:b0:37d:2ceb:ef92 with SMTP id
 ffacd0b85a97d-381f186bccamr2824736f8f.27.1731078905087; 
 Fri, 08 Nov 2024 07:15:05 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5?
 (p200300d82f3acb003f4e68943a3b36b5.dip0.t-ipconnect.de.
 [2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm115787315e9.1.2024.11.08.07.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 07:15:04 -0800 (PST)
Message-ID: <018114eb-1671-45ce-be1e-84838c33d5b3@redhat.com>
Date: Fri, 8 Nov 2024 16:15:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
From: David Hildenbrand <david@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
 <44b15731-0ee8-4e24-b4f5-0614bca594cb@oracle.com>
 <99c6d0df-4ced-4fe5-bc87-2682d1ceaa5b@redhat.com>
 <29d21f54-38e7-43a9-86fa-586bd6f957be@oracle.com>
 <115da88f-e3aa-4bfe-8842-530c06c39da2@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <115da88f-e3aa-4bfe-8842-530c06c39da2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

  
> CCing Thomas.
> 
> commit 956a78118bfc7fa512b03cbe8a77b9384c6d89f4
> Author: Thomas Huth <huth@tuxfamily.org>
> Date:   Sat Jun 30 08:45:25 2018 +0200
> 
>       m68k: Add NeXTcube machine
>       
>       It is still quite incomplete (no SCSI, no floppy emulation, no network,
>       etc.), but the firmware already shows up the debug monitor prompt in the
>       framebuffer display, so at least the very basics are already working.
>       
>       This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>       
>        https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-cube.c
>       
>       and altered quite a bit to fit the latest interface and coding conventions
>       of the current QEMU.

Staring at that link, the code was

     /* MMIO */
     cpu_register_physical_memory((uint32_t)0x2000000,0xD0000,
         cpu_register_io_memory(mmio_read, mmio_write, (void *)env,DEVICE_NATIVE_ENDIAN));
     
     /* BMAP */ //acts as a catch-all for now
     cpu_register_physical_memory((uint32_t)0x2100000,0x3A7FF,
         cpu_register_io_memory(scr_read, scr_write, (void *)env,DEVICE_NATIVE_ENDIAN));

Which we converted to

     /* MMIO */
     memory_region_init_io(mmiomem, NULL, &mmio_ops, machine, "next.mmio",
                           0xD0000);
     memory_region_add_subregion(sysmem, 0x02000000, mmiomem);

     /* BMAP memory */
     memory_region_init_ram_shared_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
                                             true, &error_fatal);
     memory_region_add_subregion(sysmem, 0x020c0000, bmapm1);


So likely the "true" was added by mistake.


-- 
Cheers,

David / dhildenb


