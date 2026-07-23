Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B2C531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmw2P-0007g8-V9; Thu, 23 Jul 2026 12:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmw2N-0007f5-V4
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmw2L-00084P-S3
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784823160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pWhu3qOg8oOBvZ9z+l+p9QVAdExRDXlYKijg9fGFw/U=;
 b=ROxH+2uc12ZKgq3NkTxWboV2YTzYC4DeedjR5EacXPCzbb2q2oMzFgnNxnKQjOjfZ/m+vJ
 nmAWI+4CGpbkEAO+zwJQx2gykAZ1zw4SQJbiMib4eh6d/SUMpVKNNhVy98LN0qseWS+jyz
 4h+eXRGdFKmROFwwQHziGMznGz2DesY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-tLQbRuHQO0mo7tzqHE_5nA-1; Thu, 23 Jul 2026 12:12:39 -0400
X-MC-Unique: tLQbRuHQO0mo7tzqHE_5nA-1
X-Mimecast-MFC-AGG-ID: tLQbRuHQO0mo7tzqHE_5nA_1784823158
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f6e658363so613664f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784823158; x=1785427958; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pWhu3qOg8oOBvZ9z+l+p9QVAdExRDXlYKijg9fGFw/U=;
 b=PxZ5a+1VrS7jQt8xbkT2UhuD8ZHpUxORl8qORpsKj8x0ykP+CiEYmV5GeOfGiFzWBa
 0K6LsDVdRHY3IrXZIK1s6y9JLBnDSuLFIUdDP8AWnfutQCfPv18KPSoP+ztOpiIV/IQh
 RKKGLnOFg+sDIxmi2WJWUAddPrhRGV+ywhm+dpir6zgieizy99e3b5nzUX5ImQ7LDjba
 U6JdabPDgwjYGAgmzR2tHEEGL2ixpKy3JvPJg1V+LwBDFqbJ8qo+S/foRwSvkhfFWqz1
 B9xvJJ32AtHttgj/Wgg9jDnT3sDCFTGBn91UBcZfZifESrn7zUXBZjHFQeQa9gwP4X6s
 RPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784823158; x=1785427958;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pWhu3qOg8oOBvZ9z+l+p9QVAdExRDXlYKijg9fGFw/U=;
 b=D38qs+zNWRn3vlEcaNdibD9HCjZx5NCahVynPl8goy3GDdkw/uMy6MFDeLqWyfuoc6
 XgsZYU2VwOzv3EVlzGN+FXWHJDfBCZ7sxUNMYaTU9/HmxhSmkrTgGd6dkXP31DkctpJ8
 QwUISheUBAfBkAWlLVWwylxiPGOBmxO3UQjLYsq4+g3AXKmhn+jpLHx3TQGis7ovRdMh
 QGS1Sl7YI80VWrfY+iT+YnDqdegs8kHUbb8ZEug6/BPc06URhktf10ORfzzjr6q7CMMy
 Nn0xh6Dq7IKSfyMyu8w5xDs3Ag+LG3WY+qIrbXR1U4XpBN6E2VX1OweMazQyqyVQRjJE
 gaSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1maedwA8LCx1NbAa3bsiuCkmyF9DLUmNGs9CN62NlYqqTloWousy4cOMNxHQ/jMnq5jlNpkecq7hy@nongnu.org
X-Gm-Message-State: AOJu0YyJKn1LD0sao1xSNrnm1wJ/RmgQ97PIRX/dFvPs3EG6rDiWi03n
 BHQhkAu3ulHQHEnaOCd0ORjBBlX6naOP4klldtHCIpr52CbeP3r/oQ9adin2t5OtVAUA9hpC0BG
 IthXXGhWt4DbnpjyMAXa/8Zbu0HD703ou/3MgFaTGTaDKKkF9j6sXm4R5
X-Gm-Gg: AR+sD10bm6Z/VsOAybKwIkTx0B8G5VA/6czjZ7Isn+xEJ6uzjNlCzFItcu0uFod0Hsb
 Ais2ge2LjFsRvcnsZccOBMoAIewhbxB5VGFWDST4oV2f8Nr28pjn4w5LYbI7DrmOUJRET4XQfQv
 Z2Qj3ipjJI2Q62zUMi1LPq/rGpIQ6rD4OSRl6sBZDn4mCSVPQ+j61+sqWaqSksujaboEEypEAII
 HoG0kxImCekZeCs0YihsA+vpXVJP3S9yAH6LuSqm1psHonPxZephG+le6mDShmL5bHJ7FAk/ukz
 34Yzz10E7mLEImdFprzH6ea26Q5VQowRZBzLMoQ/jbM8/h/10/SKRePbpQm+iQql1iqAlSW0YQ=
 =
X-Received: by 2002:a05:6000:2999:10b0:47f:934a:3029 with SMTP id
 ffacd0b85a97d-47f934a314dmr1634277f8f.60.1784823157808; 
 Thu, 23 Jul 2026 09:12:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2999:10b0:47f:934a:3029 with SMTP id
 ffacd0b85a97d-47f934a314dmr1634247f8f.60.1784823157323; 
 Thu, 23 Jul 2026 09:12:37 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a64dsm18043165f8f.1.2026.07.23.09.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:12:36 -0700 (PDT)
Message-ID: <60e0eac0-ddd6-4194-8bac-60e0fb93bcce@redhat.com>
Date: Thu, 23 Jul 2026 18:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/vmware_vga: Don't allow guest to trigger
 long running loop in host
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20260723124432.353969-1-thuth@redhat.com>
 <23cd2e91-a7ce-4943-b0d5-0f3597e675c0@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <23cd2e91-a7ce-4943-b0d5-0f3597e675c0@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/07/2026 17.05, Michael Tokarev wrote:
> On 7/23/26 15:44, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
>> basically does:
>>
>>              x = vmsvga_fifo_read(s);
>>              y = vmsvga_fifo_read(s);
>>              args = x * y;
>>              goto badcmd;
>>              ...
>> badcmd:
>>              len -= args;
>>              if (len < 0) {
>>                  goto rewind;
>>              }
>>              while (args--) {
>>                  vmsvga_fifo_read(s);
>>              }
>>
>> Thus by supplying huge values for x and y that overflow the result of
>> the multiplication, the guest can trigger a long-running loop here
>> that burns the host's CPU cycles.
>>
>> Add some sanity checks so that this cannot happen anymore.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
>> Reported-by: Feifan Qian <bea1e@proton.me>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
>> Reported-by: Tristan Madani <tristan@talencesecurity.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
>> Reported-by: Sunday Jiang
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Use SVGA_MAX_WIDTH and SVGA_MAX_HEIGHT instead of an arbitrary value
>>
>>   hw/display/vmware_vga.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
>> index f6f9edfd1d9..567806f0e47 100644
>> --- a/hw/display/vmware_vga.c
>> +++ b/hw/display/vmware_vga.c
>> @@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
>>               vmsvga_fifo_read(s);
>>               x = vmsvga_fifo_read(s);
>>               y = vmsvga_fifo_read(s);
>> +            if (x < 0 || x >= SVGA_MAX_WIDTH ||
>> +                y < 0 || y >= SVGA_MAX_HEIGHT) {
> 
> Applied to the trivial-patches tree, dropping <0 conditions here.

Please don't drop the "< 0" ! x and y are signed variables, so we should 
better check this here.

  Thanks,
   Thomas


