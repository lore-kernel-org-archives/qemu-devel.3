Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FBBC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 04:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta65Z-0005NK-Kc; Mon, 20 Jan 2025 23:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1ta65Y-0005NB-Ir
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:42:08 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1ta65W-0002ML-Fm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:42:08 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f441904a42so9289041a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 20:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737434524; x=1738039324; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8glFbR6c2NMBAqcRrLJz3z8ifrbgIlQ6nKk3F8oLF94=;
 b=hEJZ2sfwSAjqLVe2HxtfnmAQWXcGZUhv7z0hPgQW1FspXFGzAOScHDAQDn75RYqcDz
 wM914b2a2rz2Drqn9E18uyQaFpzQZWGZr3+Ai3UI5H4jwu5/mXBE4JLq2aZ75dnc10Xz
 Rh7jViHiQo0TXhLnhv9TphZYbKdhnZ7l0m+HeofSXNwO9l+38HGp/6QrkYJO29oL0vo9
 pKKvf7HEOnC2saS9CS/68Ah+iQ0Xqmzk98CVdr/Mebiv+4OxjOSAvxsx/VbHxwIB5f0U
 rlPuo0clt7oi3B5ppy4owjO/k9jQM104aVzCmRAZ2Hj3VRfttXX8J0laMSlSsKFtSt9m
 nlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737434524; x=1738039324;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8glFbR6c2NMBAqcRrLJz3z8ifrbgIlQ6nKk3F8oLF94=;
 b=wjP0/iNhN5UtltSfVivSylbVMh8jxFmT/16S9/+mOj39ghXeGnkVNsZvQ4MlbjAobN
 n7lpIqIFD/CzrgUIEp2awNmmstfI3wigF8O6F/S8dqKK2fyeupAOW1pEmvXyt7nZRaQN
 KeXARrWi0mdpKzTl/XTRzwaPqtf1m/cFjZepVf/XAkV42HQo9DuyVTkdLGgoJ3gOHzfG
 PcyWE4usf5a9uc2G00Vpb8bZmWpXu0ONPCxrrRtE1ySvK0AwmCdliE+hTC5TEmcPghlU
 7ayuNDC2EYNIVumLoOZcRoHESvxipNEky8KhvcjdvZO6h6xHq4ZV87XrLuBOvCCumbnF
 ECOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGbGM3roHUCbj3eaH8QnrJJ0lGGx3YK58KWqzMtxEBldfXVapVxSey33fVlReoNXsZtGwu7SVxF0bp@nongnu.org
X-Gm-Message-State: AOJu0YwoTYLddt5C2yzEENlaRPfSQ5ZT7pu+iJ5qmFUY6bDUYhnFnp6f
 5R3Y24ePDi/kKWBPReTjXDGStLF+89LxzQf0xYOCI6VBt7Fsd77s
X-Gm-Gg: ASbGncs21yz7j3CM5atKNGBEz2AJjqVqx5kitmxOVLMP3gPlw6cUjVc6gkT3yH61aIi
 X6/aSwAcwGmmsJVrrrlBXNUDCZofRnwl0FzM9lGUBtQkY7aj0ntsjYv7nu9Q18BwEuIXcj/zn/R
 H/m7SkQvu1HwyrJCDU0LfxRTvj2TXGQEIAPFBoo7CfcUlJ9SwmQi5MJ51IZGJzitpBST96PSPMw
 W9wND5fyVewR/XYFJg68Ga6F8caqXNdjQtEtnYUhcVT6L2wsAger/Hyt4ZaFAay
X-Google-Smtp-Source: AGHT+IEKKo9pl9qr7gU0Q+OYtdAjVuVxKF48KYXt4h552YOXqnLUD81k45za2C10xHKLgc8IQxVFiw==
X-Received: by 2002:a17:90b:2c83:b0:2f2:a664:df20 with SMTP id
 98e67ed59e1d1-2f782c6750cmr25846772a91.7.1737434523882; 
 Mon, 20 Jan 2025 20:42:03 -0800 (PST)
Received: from localhost ([138.44.251.158]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c2f31d6sm11739747a91.40.2025.01.20.20.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 20:42:03 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 14:41:45 +1000
Message-Id: <D77H4P297PKY.25UZ63LQ3915T@gmail.com>
To: "Phil Dennis-Jordan" <lists@philjordan.eu>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] hw/pci: Assert a bar is not registered multiple times
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250117172842.406338-1-npiggin@gmail.com>
 <20250117172842.406338-3-npiggin@gmail.com>
 <CAGCz3vtDjaVnWbnZdKQSEReoWdtrMpyJGVkzXu4Q8XaVPYciFw@mail.gmail.com>
In-Reply-To: <CAGCz3vtDjaVnWbnZdKQSEReoWdtrMpyJGVkzXu4Q8XaVPYciFw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun Jan 19, 2025 at 8:38 PM AEST, Phil Dennis-Jordan wrote:
> Looks good to me. There is a risk here that the assertion will fail on
> existing code. (Unless you've rigorously audited all callers, which would
> be quite the task.) However, I agree that this would constitute a bug in
> the calling code, not an issue with this change. Since we've still got a
> few months left in the 10.0 release cycle, I say go for it - hopefully su=
ch
> bugs, if there are any, will be shaken out over the next few weeks.

You're right I didn't do an exhaustive audit or test beyond CI and some
browsing. I think it would be quite buggy already if this happens so we
should just catch and fix it quickly, but happy to change to a warning
first if anybody is concerned.

Thanks,
Nick

>
> On Fri, 17 Jan 2025 at 18:29, Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> Nothing should be doing this, but it doesn't get caught by
>> pci_register_bar(). Add an assertion to prevent misuse.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>
>
>> ---
>>  hw/pci/pci.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 2afa423925c..b067a55c5bc 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1391,6 +1391,7 @@ void pci_register_bar(PCIDevice *pci_dev, int
>> region_num,
>>      assert(hdr_type !=3D PCI_HEADER_TYPE_BRIDGE || region_num < 2);
>>
>>      r =3D &pci_dev->io_regions[region_num];
>> +    assert(!r->size);
>>      r->addr =3D PCI_BAR_UNMAPPED;
>>      r->size =3D size;
>>      r->type =3D type;
>> --
>> 2.45.2
>>
>>
>>


