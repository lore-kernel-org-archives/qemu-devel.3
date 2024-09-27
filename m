Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADD4CEBF9C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 12:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su9jM-0002ox-Rv; Fri, 27 Sep 2024 08:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1su9jI-0002nA-8H
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1su9jD-0000mP-5e
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727438740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nVJ2m23PaBelOcHiYYYnQT20/nSh8FOm58djKkBiopo=;
 b=aMxKGi5Kvj7d4ozMNj6XpjJrR/zPp0tzWOhDMlclKUUmLLhwOC8zIbNw2ZBBUjqb0vhS4s
 YWqZp7cTO3D4vO0lpiBLjj+KEnjfUZa8vsGgBYuhzek9GaMewrzG4WljIvtAod+xBXu1jz
 Nca58ExFjXxM2kTI3Dii1M/AHjQeM+Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-rhrncpITOuC9ajVgtsi4Pw-1; Fri, 27 Sep 2024 08:05:39 -0400
X-MC-Unique: rhrncpITOuC9ajVgtsi4Pw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c422368ce4so1126372a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 05:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727438737; x=1728043537;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nVJ2m23PaBelOcHiYYYnQT20/nSh8FOm58djKkBiopo=;
 b=p6HgLm+KxhcAnViK+o3YDJZ8xhPH6F/aGRQU58LG6qdbfNdmZu/D+LGMjR1Om42GYn
 qzwD7VdG4UV+XZPHRyk3mZyg0xBnMOnBS6my7PLWQQIyvHIKg0ihYHlpVqBDPt7W3f0c
 VgkZizaHUn5UYFPJgQUngbf25pQI9tR1WxAqS2bNZfN8IqIK+hX0dXScgbdLabUzcEfI
 bH8NaVXAFDSSjyqnkpQA3+zV0ZxZTXZHechuAYQCQrUZrJhau4uS6xZsgHzv8v5xJGfL
 svDQThSpUrAWVup6G3gtY9LvjrdEoBhXWZJexRUNKccmqKCA/aSnshgNwzK65G6jqiw3
 o09A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb+okxaoRwCsf3HCR6JD5d+borjvzF42DbzREGUziizQ873TPTFvvySlbIKgdJ0xqZjltoTjmILyoc@nongnu.org
X-Gm-Message-State: AOJu0YzgSBEkm7PbVhXvtkwxp6iaNB6QY1UkhApQ2G4dIhxWQu6EP5Im
 msrZnZtUtzAxFePfc4T0I9C7S53EkStZguCVLA1mxYviTU6cZKCAXMS0JnOV6bDF9p6mcNmKbvF
 saed36IMIqs7NeNvTo30ibabEk9nQbDXNeo+b3Pr1e8mXgjf2bhaE
X-Received: by 2002:a05:6402:4019:b0:5c8:77a5:d469 with SMTP id
 4fb4d7f45d1cf-5c88261ab43mr2475496a12.26.1727438736686; 
 Fri, 27 Sep 2024 05:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1hstPHvnYb0TI/LdGe3eE4lzWURymWkKCeYYk8dCh9bxZJfniFxOqjRrhfGx6xxHrZZlPcQ==
X-Received: by 2002:a05:6402:4019:b0:5c8:77a5:d469 with SMTP id
 4fb4d7f45d1cf-5c88261ab43mr2475456a12.26.1727438735790; 
 Fri, 27 Sep 2024 05:05:35 -0700 (PDT)
Received: from [192.168.10.81] ([151.62.109.139])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5c882405692sm1094196a12.10.2024.09.27.05.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 05:05:35 -0700 (PDT)
Message-ID: <4bd26d6c-1f68-43e9-ac99-b542f24676ef@redhat.com>
Date: Fri, 27 Sep 2024 14:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/x86: Always treat the PVH entrypoint as a 32-bit field
To: Ard Biesheuvel <ardb+git@google.com>, qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>
References: <20240927071950.1458596-1-ardb+git@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240927071950.1458596-1-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/27/24 09:19, Ard Biesheuvel wrote:
> -
> -        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
>       }
>   
> +    pvh_start_addr = *(uint32_t *)elf_note_data_addr;

I think we even want ldl_le_p(elf_note_data_addr) here?  It makes no 
sense to read big-endian data.

Paolo


