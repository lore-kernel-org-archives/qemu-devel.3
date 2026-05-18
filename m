Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835AACD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1bt-0006Sd-Fn; Mon, 18 May 2026 13:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP1br-0006SJ-9Z
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP1bo-0007ur-P9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779124706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lOvNXOCBjQKup2LWaNRNMo90eLKg8P4GXtjUD6lZQkk=;
 b=aSfTwNIKUTj7TroOQm68rSTtIJXF3Q2LCoQ81WaJKMWHPPLUSa4OCF5bCbtKadYxiSXAKt
 jBqqyqmXUN3J3ZzjItwXmwzpmjt13HBtgpSd5t+XNDdIrbEZSosaaMUTO82H18Bl8kzYm1
 5of0DNYUtE+/Q7BFujEDzmVu/VrhRik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-lA9tpULrNzqSxoy_rpP0TQ-1; Mon, 18 May 2026 13:18:25 -0400
X-MC-Unique: lA9tpULrNzqSxoy_rpP0TQ-1
X-Mimecast-MFC-AGG-ID: lA9tpULrNzqSxoy_rpP0TQ_1779124704
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe3e73da6so12285585e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779124704; x=1779729504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lOvNXOCBjQKup2LWaNRNMo90eLKg8P4GXtjUD6lZQkk=;
 b=jRfdBFuSREukjHdSLhiYHevaO6jqEtZYXXKJyCDd1bVrjcOrTQxH/ZHilWsWv2KOmK
 wlwQoi5u734oLmzSHd7tdbKiI/7ZliVpcbq/wUdX+AC0YzxwTg4GdHsNMt+DNYOSyodW
 baa500AkY1TxgD5EG79v138ByH9pqJ/pxjbjR0tbyOdS1XXYHZk65TWl1O5zg3vyq3i3
 n/rwaUWCuLnnFizD5HQPMUKlbvhlbm9lq0JJcXM5gtkqwCAkS3+VqMpWUXMcqJcR5wET
 PzwGeocElGcTACHDvceUN2nApAoEVRdNzSq8vmRmtCXEUpq4vKdtdlvASa4+U/5p4EtS
 pq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779124704; x=1779729504;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOvNXOCBjQKup2LWaNRNMo90eLKg8P4GXtjUD6lZQkk=;
 b=swFHT9ie4kLLbbiM4Gnuv/vHpvZ7J8d0vfiEWXKS/njij+G1B7LQxPUXLKaDc4Lwkm
 /CpZLYrF1BKy0CeZ/dylt8poDZttamH1SkOJANgzUWIWXo2HBSZZx1WeRsK2+cePzztn
 Pd34qSt7mmPOCEmXo3lD3AXD9jti55/SWtbNH1uVKRgg4LR7AB6lzw7I2wl9uzSaq7I8
 +Jo+odt/9/a9fZyWZtNaopa+vFJzbOTgL1vml9Ut5oO2FqNw5rWT8DqI9KBw3c/EfHZZ
 0aF5qXOj+bQTVXdnZ4+yXgXZfnkV11N0Gx7HpXB8TiH0nQsf/aKsY62CXAtbqz+ripkz
 8xhg==
X-Gm-Message-State: AOJu0YyhgAvZYfE4dYyxoBgvu772CGDCstjBrnEOTfBmucYxlq4pP3ip
 F5QhDfmfM6ASfrRn91vTGmo/46InOQhvQfg5iYBfmRrCel9cufac1VEfEILOks5DjYxDHTnM7Du
 N/GmDzK8oQEiwzEqZS5WEcv44Xvr8Og0XNVmSZC8dNoMxUkaD5rxtZgqE
X-Gm-Gg: Acq92OEvZ4/ceVF8HmJgIyHebZ0MLTY9TIJTS5PQAVGVqI43DRgWh4nDBBU7s8iRll+
 9xBmyGag7XeOdxrGJKgRAMtUj2h3+OHCWeGqPBo1JB1xHEQdOsULra3ttbP3+5XxVhyJaKGvaAu
 b67qNcoIDGoo5QUoBRsi3dnubYvXsqH6vEvlZuPo0/fyKbLQ17DmbVZMg1zMW2WaLNeV8yRW1zE
 mnvphy7vJ0oCxbdGaat/kNdfpS4OCGEMukb8tdDYpjF9KKOdHw5kA4pzjT7Vl8DN7aF75zzhQIO
 bGeQFgoJOrXFUZqRuYF79DzGgBc/12LRbpQ0wwGd0dr6b6LB/++Pql7aiqoTpOinPMdhyaqCJf6
 kzUeFuIZpRhN0C6NBIw==
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48fe5fcdf50mr236268025e9.1.1779124704089; 
 Mon, 18 May 2026 10:18:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48fe5fcdf50mr236267585e9.1.1779124703735; 
 Mon, 18 May 2026 10:18:23 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537ccf5sm262756865e9.14.2026.05.18.10.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 10:18:23 -0700 (PDT)
Message-ID: <bd11fa7d-79ec-4125-8669-392482a2e933@redhat.com>
Date: Mon, 18 May 2026 19:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Implement -run-with exit-with-parent=on
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, berrange@redhat.com
References: <20251009161526.140497-1-rjones@redhat.com>
 <20251009161526.140497-2-rjones@redhat.com>
 <59f45360-5676-41a7-8c4a-577c3e645aa7@redhat.com>
 <20260518165440.GX1447@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260518165440.GX1447@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/05/2026 18.54, Richard W.M. Jones wrote:
> On Mon, May 18, 2026 at 06:49:11PM +0200, Thomas Huth wrote:
>> On 09/10/2025 18.12, Richard W.M. Jones wrote:
>>> +static void *
>>> +exit_with_parent_loop(void *vp)
>>> +{
>>> +    const pid_t ppid = getppid();
>>> +    int fd;
>>> +    struct kevent kev, res[1];
>>> +    int r;
>>> +
>>> +    /* Register the kevent to wait for ppid to exit. */
>>> +    fd = kqueue();
>>> +    if (fd == -1) {
>>> +        error_report("exit_with_parent_loop: kqueue: %m");
>>> +        return NULL;
>>> +    }
>>> +    EV_SET(&kev, ppid, EVFILT_PROC, EV_ADD | EV_ENABLE, NOTE_EXIT, 0, NULL);
>>> +    if (kevent(fd, &kev, 1, NULL, 0, NULL) == -1) {
>>> +        error_report("exit_with_parent_loop: kevent: %m");
>>> +        close(fd);
>>
>> So in case of errors, fd is closed here ...
>>
>>> +        return NULL;
>>> +    }
>>> +
>>> +    /* Wait for the kevent to happen. */
>>> +    r = kevent(fd, 0, 0, res, 1, NULL);
>>> +    if (r == 1 && res[0].ident == ppid) {
>>> +        /* Behave like Linux and FreeBSD above, as if SIGTERM was sent */
>>> +        qemu_system_killed(SIGTERM, ppid);
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>> ... but if everything goes well, fd does not get closed? Should
>> there be a close(fd) after the kevent() here?
> 
> Yes .. although of course qemu as a whole will exit very soon
> afterwards :-)
> 
> Do you want me to submit a patch or will you do it?

If you've got some spare minutes, I'd appreciate if you could send a patch.

  Thanks,
   Thomas


