Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9ECEE01FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDg6-00076B-U7; Tue, 10 Sep 2024 23:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soDg5-00072v-C2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:05:57 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soDg1-0007DP-KM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:05:56 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d87176316eso329517a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726023951; x=1726628751;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nhAzBDdApRlmVB59bNk0Jq/Vsl/NloT5GQqZHXoixhQ=;
 b=0+NfT5YARegz1YIrK9Bp6njpsmdSmTpsiAUw+NCnCOTe2RZNyzLz1qFiLT0eveJY1/
 UL2810tGLyvPKxTcf0Q4CV7KjtzTJWyv6ZnZLWsdwgaaith2kuwYsbyuDsu808Ev1PBi
 pGqUc/+xJF1oTrmoQsiKQuwmGvBx+Fdf2Aw4BKp1XvxJYa+WkOFC450QBimTlCH3A7Ln
 LlMOqmQImjBcjaOBbRjqYq/BaW1rmGQP0fiTjOGMbvue7fPwZvBsykVnTmBQ8A+EhX0p
 aLk17SvKlLabw9zkVVhAqBYd8xdfEUsQRtUjWxfEiDBzcwIW5ApkTVsD2gEIy5kPpJJv
 6YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726023951; x=1726628751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nhAzBDdApRlmVB59bNk0Jq/Vsl/NloT5GQqZHXoixhQ=;
 b=cQBwAFE4yvkNbYPWyMmu/k9P5gHwk511fg7pmmn9TEAQwiKUHs5Thm98U0P1TsYPdP
 /egTz9oJpAAq0LngMSnFW0MQL1VcEDzmzR8wEBEpE4iwcChVmLWmKbeWnvZnLmo2ZD7l
 RGxOnFnAPGc8Lt7WhlaJfdlkmR5NaNHb/K8PXXtBQN0/JiUGrNHHt/fiWPzuzI/jYSLu
 pCPnfH/m/FmOuiutRxfhW0MlTAT8zXpwczwwZ94JsUzXELew34ozGxaWWr+MCtBY01DG
 D5N9TAuXUXwIxGQGTGj9NO2uUs2HoQlezBMcxKL2BOPbBlF1BKGzWQ2W/01lJZq+FLCM
 ZDFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAsB3Xh8vl3Re2wYncSW7g7XDdBu7PBWrPjUfDfuiyQDdKBzzgSRc1cLObdLqObggM132IthLVIn0m@nongnu.org
X-Gm-Message-State: AOJu0YyDU9nC6HUKSN7tAWzkhSobPXQ59KMshrE+uVAXfjPJTaq2v9VB
 L9szOO9Hg/ERPgKtCvT+T1Cqo8PaTY1d8VMiGMKx4irOKmOfQk4GT5cJGFjMGyg=
X-Google-Smtp-Source: AGHT+IGjZrQmo2QFBdw+fYqPyo7aJ47E3CShefeO/1npL5LT0GZ/V2B8QNl9c65Gzcf66HLfuu8C/A==
X-Received: by 2002:a17:90b:18e:b0:2cf:f860:f13b with SMTP id
 98e67ed59e1d1-2db671fea18mr7719695a91.17.1726023950849; 
 Tue, 10 Sep 2024 20:05:50 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04988c97sm7141056a91.55.2024.09.10.20.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:05:50 -0700 (PDT)
Message-ID: <3f0e049e-8030-4901-98ea-be17369db59a@daynix.com>
Date: Wed, 11 Sep 2024 12:05:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
 <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
 <20240910093440-mutt-send-email-mst@kernel.org>
 <6aeaa38c-22b9-4598-b07e-7adaee187562@redhat.com>
 <20240910112723-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240910112723-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/09/11 0:27, Michael S. Tsirkin wrote:
> On Tue, Sep 10, 2024 at 04:13:14PM +0200, Cédric Le Goater wrote:
>> On 9/10/24 15:34, Michael S. Tsirkin wrote:
>>> On Tue, Sep 10, 2024 at 03:21:54PM +0200, Cédric Le Goater wrote:
>>>> On 9/10/24 11:33, Akihiko Odaki wrote:
>>>>> On 2024/09/10 18:21, Michael S. Tsirkin wrote:
>>>>>> On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
>>>>>>> Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>>>>>>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
>>>>>>>
>>>>>>> I submitted a RFC series[1] to add support for SR-IOV emulation to
>>>>>>> virtio-net-pci. During the development of the series, I fixed some
>>>>>>> trivial bugs and made improvements that I think are independently
>>>>>>> useful. This series extracts those fixes and improvements from the RFC
>>>>>>> series.
>>>>>>>
>>>>>>> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
>>>>>>>
>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>
>>>>>> I don't think Cédric's issues have been addressed, am I wrong?
>>>>>> Cédric, what is your take?
>>>>>
>>>>> I put the URI to Cédric's report here:
>>>>> https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com
>>>>>
>>>>> This issue was dealt with patch "s390x/pci: Check for multifunction after device realization". I found that s390x on QEMU does not support multifunction and SR-IOV devices accidentally circumvent this restriction, which means igb was never supposed to work with s390x. The patch prevents adding SR-IOV devices to s390x to ensure the restriction is properly enforced.
>>>>
>>>> yes, indeed and it seems to fix :
>>>>
>>>>     6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
>>>>
>>>> I will update patch 4.
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>> That said, the igb device worked perfectly fine under the s390x machine.
>>>
>>> And it works for you after this patchset, yes?
>>
>> ah no, IGB is not an available device for the s390x machine anymore :
>>
>>    qemu-system-s390x: -device igb,netdev=net1,mac=C0:FF:EE:00:00:13: multifunction not supported in s390
> 
> 
> So patch 4 didn't relly help.
> 
> 
>> This is what commit 57da367b9ec4 ("s390x/pci: forbid multifunction
>> pci device") initially required (and later broken by 6069bcdeacee).
>> So I guess we are fine with the expected behavior.
>>
>> Thanks,
>>
>> C.
> 
> Better to fix than to guess if there are users, I think.

Yes, but it will require some knowledge of s390x, which I cannot provide.

Commit 57da367b9ec4 ("s390x/pci: forbid multifunction pci device") says 
having a multifunction device will make the guest spin forever. That is 
not what Cédric observed with igb so it may no longer be relevant, but I 
cannot be sure that the problem is resolved without understanding how 
multifunction devices are supposed to work with s390x.

Ideally someone with s390x expertise should check relevant hardware 
documentation and confirm QEMU properly implements mutlifunction 
devices. Let's keep the restriction until then.

Regards,
Akihiko Odaki

