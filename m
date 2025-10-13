Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F4CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BmZ-0003Y8-Cu; Mon, 13 Oct 2025 02:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8BmX-0003Xw-Hx
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8BmU-0005Ts-Ov
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760335894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=at5f2NRlbqGFZ2wBvJrtSpjSO4RZdF+bmN53A+B4Ypk=;
 b=iYsL5SmnYtPnKuUYwws44Yg04JDys6mKWDRMzytSGCpOJZTwB2POZrbuGbo6aGF5kk159S
 gbNXKXCvGOm+BOGkJSlUMK0LNpt7P+fj1uxyEMOHuR8R0lE8+J2E0sxVKCMyUZ22LiH4uk
 La+VEkxkcSjJ0MvRjP+9NF60DcVZDZQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-uBzpKth6O8GXUEgIVrI_tQ-1; Mon, 13 Oct 2025 02:11:31 -0400
X-MC-Unique: uBzpKth6O8GXUEgIVrI_tQ-1
X-Mimecast-MFC-AGG-ID: uBzpKth6O8GXUEgIVrI_tQ_1760335890
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d73e1ed87so538173166b.1
 for <qemu-devel@nongnu.org>; Sun, 12 Oct 2025 23:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760335890; x=1760940690;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=at5f2NRlbqGFZ2wBvJrtSpjSO4RZdF+bmN53A+B4Ypk=;
 b=Rl6VG5bt9x/6MIcNyBvT/DNQUYQ2oBCelphkFnhASy26JZYrFGAfUjis44N3hYOixB
 7/rgz2OnMzIvWy26CnQ0Cmy/gqP/DdR+kKJE/OatkoZL6J9SKqtbOGta8SHDp75GPZip
 QnqlLANQh9gMjiVZMmHByJVsKUWtp9On3ZXcNgaY1N5U0Wxx67h7scEKcfoA0+IBCBVo
 cl1jTJv9grD1ZBOgsk3x8nC4Cm41fxt/M0bJ0JscJt9mKllUnFdSnkBuBG2NqR9p5s5P
 ibhKefd9PgDV97E9FL4ISnX6hmH4WFnOOrOT86jwHBuQE3a0h/uysUNJJoQnTMUCmQB9
 ASJQ==
X-Gm-Message-State: AOJu0Yy/uBcbuqMaivAlqcnewWyqsiYIFQiEidvDKciE1bcewBS8AFzn
 xs8zuqG1bS9COHegHlfuLy7QkUZFNZEOOXnCL0m0sCfxyYt1U9P7g9big/5gqwrvuAwxWWsPGHG
 ujtMCL1rkHjhoXAk1e3MzKKlkbrFj22QBU8TBHD4rtBRg2xuhHqJafVym
X-Gm-Gg: ASbGncsxa0ruKqz5WyEw5vhlZw8SWw4m/IYKNdIZK5LQo98CkLp7KEhTR8YLlgQGW0W
 oVgtkt2QUJNTR8kVGMIMSi1NOyQcW8/C2hUV0euORAMar/jzAmb8CaU5deZpUH+h8E2CF1mZpIh
 6oXfV1iky+VV+DQFPmgsB8OGH3ysKCURvpfqc8rH59dl8n/k3itnNH9jLBmxdUsaTR5eN7aeJUQ
 u8SnG4zs+2GBhiImGycfpeFElTuCYoJsBINbCp2tMKLWEZJNRog/ufpEiMeFbDz3s9QFVV4wEap
 cxF+Jn8z0VFiIlYFHtP7uTGEHdMa8C++osSZj5FERHiO0B2iyNgZwnzUS5v2hfDXpEEd1O8x4Zi
 paBhu
X-Received: by 2002:a17:907:d48d:b0:b4d:71e9:1662 with SMTP id
 a640c23a62f3a-b4f43730a39mr2892565666b.30.1760335890145; 
 Sun, 12 Oct 2025 23:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKx0mIPa2v0hxQcwvglAdHDoA56W37P1VRTXCtDEcgWHgyYW96qcPpTBtZyXIm8gbuQ+QFg==
X-Received: by 2002:a17:907:d48d:b0:b4d:71e9:1662 with SMTP id
 a640c23a62f3a-b4f43730a39mr2892564866b.30.1760335889793; 
 Sun, 12 Oct 2025 23:11:29 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d9525bdesm855245466b.78.2025.10.12.23.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Oct 2025 23:11:29 -0700 (PDT)
Message-ID: <2e4da035-4996-4d1e-b3e1-9285a9c880e3@redhat.com>
Date: Mon, 13 Oct 2025 08:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] qapi: docs: width=70 and two spaces between
 sentences
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/10/2025 15.56, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Let's bring the documentation in line with the requirements. And
> do check these requirements in QAPI parser, to avoid later
> further violations.
> 
> Vladimir Sementsov-Ogievskiy (33):
>    qapi: Add documentation format validation
>    qapi/acpi.json: docs: width=70 and two spaces between sentences
>    qapi/audio.json: docs: width=70 and two spaces between sentences
>    qapi/block-core.json: docs: width=70 and two spaces between sentences
>    qapi/block-export.json: docs: width=70 and two spaces between
>      sentences
>    qapi/block.json: docs: width=70 and two spaces between sentences
>    qapi/char.json: docs: width=70 and two spaces between sentences
>    qapi/crypto.json: docs: width=70 and two spaces between sentences
>    qapi/dump.json: docs: width=70 and two spaces between sentences
>    qapi/introspect.json: docs: width=70 and two spaces between sentences
>    qapi/job.json: docs: width=70 and two spaces between sentences
>    qapi/machine-s390x.json: docs: width=70 and two spaces between
>      sentences
>    qapi/machine.json: docs: width=70 and two spaces between sentences
>    qapi/migration.json: docs: width=70 and two spaces between sentences
>    qapi/misc-arm.json: docs: width=70 and two spaces between sentences
>    qapi/misc-i386.json: docs: width=70 and two spaces between sentences
>    qapi/misc.json: docs: width=70 and two spaces between sentences
>    qapi/net.json: docs: width=70 and two spaces between sentences
>    qapi/qdev.json: docs: width=70 and two spaces between sentences
>    qapi/qom.json: docs: width=70 and two spaces between sentences
>    qapi/replay.json: docs: width=70 and two spaces between sentences
>    qapi/rocker.json: docs: width=70 and two spaces between sentences
>    qapi/run-state.json: docs: width=70 and two spaces between sentences
>    qapi/sockets.json: docs: width=70 and two spaces between sentences
>    qapi/stats.json: docs: width=70 and two spaces between sentences
>    qapi/tpm.json: docs: width=70 and two spaces between sentences
>    qapi/trace.json: docs: width=70 and two spaces between sentences
>    qapi/transaction.json: docs: width=70 and two spaces between sentences
>    qapi/ui.json: docs: width=70 and two spaces between sentences
>    qapi/vfio.json: docs: width=70 and two spaces between sentences
>    qapi/virtio.json: docs: width=70 and two spaces between sentences
>    qga/qapi-schema.json: docs: width=70 and two spaces between sentences
>    qapi/acpi-hest.json: docs: width=70 and two spaces between sentences

Oh my, that's a lot of code churn for very few gain. Why do we have a 
different standard (70 columns) for qapi docs than for the rest of the code 
(80 columns)? That's confusing and will always cause mistakes in the future, 
I guess...

  Thomas


