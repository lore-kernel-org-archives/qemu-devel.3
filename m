Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DDCC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiOr-0001yr-PB; Tue, 14 Jul 2026 15:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjiOq-0001y6-70
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjiOo-0007oJ-1v
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784055752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=usVvZaGoRWzWV0yTDTdTV1KrxqLDEnSa6Xc31r3ttSM=;
 b=TOCOXSpLOM7hLX1v/NeudNRXpJJE9cOfejl0eAwI8NTDAJrTMP3RY8mBMB5qXS8Z0z+P8a
 +fQxITI/haen79Xua/tfz3Uwx1kUIAvS30r+AD6/D76WvqlXsY6yypoulCx7PWO8Ui3V4H
 8R1VTdFyVuQOJvevDp4X+SBWlpq5nRE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-wbDFO36bPluyYeLZ-_N0-A-1; Tue, 14 Jul 2026 15:02:30 -0400
X-MC-Unique: wbDFO36bPluyYeLZ-_N0-A-1
X-Mimecast-MFC-AGG-ID: wbDFO36bPluyYeLZ-_N0-A_1784055749
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473f4a48e9aso3067916f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784055749; x=1784660549; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=usVvZaGoRWzWV0yTDTdTV1KrxqLDEnSa6Xc31r3ttSM=;
 b=SxonIwIXKjnKoOSljJJrAF8THoroB0wi47+3uAt5mLnU4r5DQ/hAFmmqxqk6vSRUuv
 Tt3OXHAlPDyvl6XRT3GV5+vgISeWVRJZalNFxXcyWPOAMZz6Vzu85QGyg/t24BcLXJ0Y
 SwIJDzE+2x6POOSVWywvHNqpgooUBVJQN2JIbDtG8SnChjtgnhSFkNFp38FenNl6DB7C
 TimwPYM4SvyvYIIDjOVBcFTE6+HnTA3aN4ziMxsw5fl3BgL92ozen5A9AAHEyAj1Zpuy
 y/ycHlvFutx5Dm0R8HZjpkGR4ZKpxQHoulS1jZr2HpiTgOcB5bWxVI8VXz8IEX4ejxNS
 wxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784055749; x=1784660549;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=usVvZaGoRWzWV0yTDTdTV1KrxqLDEnSa6Xc31r3ttSM=;
 b=XWfF92rJMCXy3n1Fo1ErRsr0zBpMw5mEtEckDj7O6eZo+47KvGYxI71uRrYc4lCqIc
 ocprIeFYAAd4X7Zl8v5s63tmCw+xTkWWMlSTopC0QHTn5ldetuad5IcViKcAf4ATy/jw
 WfaWdnaquj6sBMa+NhWi1E174Hz+PCt0UmY+zy1vctVEAyMIzd4pJAqpopTdZDtP54p6
 KPd6FTq4nP2N9A0f+ppSRjqoLq40pp/oPtoy+GYEYd2tKPTX4eE8w/PLLgSVll0ABARQ
 QuEhvsra4WFlf4JUofSSK1R3tVhveNbf+8m5+jqEDZ+H6PoPhjwWrOHR6GLNpvHkItPu
 4uhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI5WNJD4l7AhF6uPsX1cludY9AS/gdKMbi2wfiU1L51zAnXfNjdXuFlK2kdbN4Jt3Cxh5wkV1Nwru6@nongnu.org
X-Gm-Message-State: AOJu0YzLl5FNcLPANVTnnbdyqAYO2GOmkUY3jYH5PirJNRsAo/HZM6Bu
 NQYvQnxhG8ZZiQJC4QAv/LDGiuDvE9mUolaBummmyM6MO8LzEO2GV7ZUs2EnrJkGAUlyht5l3a5
 g/u/eK0+3Jfhxd51A86IFDlFHpJ7wqikciTzgrdgN61aVrqGw/CD8ctDj
X-Gm-Gg: AfdE7ck2vP4fqf0L+s6YmMi1cHbmYw12u/gJcqt36IXxvenZTJoaPOO2k/oTXnpZgdB
 9yiNZjyX/j7n3hONbiPePLFuFpdwFb1K1mIly5lVtWl3sTBtxFJiWUDDPv7l/nMVWJTQU56nH0W
 FsWeeT19DucRL6+n75f/zh58u/9MgDzvFQj0ZRoceyOLiOhwP2BNlKgMzaBwHg4FtJts7VI697c
 VOr/0egKQP2uEovdZKm+HXQe4fmw7xrINh/HajKCGal9SvOG3lJ/J3UUQ5MT1K4tOPXRamJjJ0x
 SalVwT+NbbRpo7+AVW/W6OWLiP5RYdHCr7cMGnIvADlLIlTx+cDBO7/Nk8Cwe4qOV7nX/xrthcj
 561Tg3ore
X-Received: by 2002:a05:6000:22c2:b0:47d:ef62:cae0 with SMTP id
 ffacd0b85a97d-47f488c9ae9mr4418905f8f.51.1784055749230; 
 Tue, 14 Jul 2026 12:02:29 -0700 (PDT)
X-Received: by 2002:a05:6000:22c2:b0:47d:ef62:cae0 with SMTP id
 ffacd0b85a97d-47f488c9ae9mr4418882f8f.51.1784055748831; 
 Tue, 14 Jul 2026 12:02:28 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7e22sm10038809f8f.25.2026.07.14.12.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 12:02:28 -0700 (PDT)
Message-ID: <a8c6e102-0860-4db3-9393-3c0a10f45c6c@redhat.com>
Date: Tue, 14 Jul 2026 21:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Print simple help text when calling "-blockdev
 help"
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
References: <20260710093654.466642-1-thuth@redhat.com>
 <alYTtDv4m1ikN6vH@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <alYTtDv4m1ikN6vH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 14/07/2026 12.47, Kevin Wolf wrote:
> Am 10.07.2026 um 11:36 hat Thomas Huth geschrieben:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Other command line options like "-chardev", "-netdev" or "-device"
>> already present the user with a list of available parameters, but
>> when running "-blockdev help", there is currently only an error
>> message. There is already the possibility to run "-drive format=help",
>> but it does not seem to be documented, so this is not very useful
>> for the average user. Let's improve this situation by providing
>> the same list of available drivers when running QEMU with
>> "-blockdev help".
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Seems like a good idea to print at least some minimal help there.
> However, I find the list from -drive format=help quite hard to read, and
> repeating the same list twice for read-write and read-only doesn't help
> either.
> 
> I don't expect we can change -drive because I seem to remember that
> management tools look at it, but can we make -blockdev help more
> consistent with the other examples you mention? Something like this:
> 
>      Available blockdev drivers:
>        blkdebug
>        blklogwrites (read-only)
>        blkreplay
>        ...

Yes, that's a good idea. I'll try to have a look at it.

> Ideally, I'd also love to have a way to show all the options a specific
> driver offers, but that probably won't happen before Markus QAPIfies the
> CLI. :-)
This would be super helpful, indeed. It's really useful that we've already 
got this implemented for "-device xyz,help", would be very cool if we can 
finally also get this for -netdev (where it is also still missing) and
-blockdev.

  Thomas


