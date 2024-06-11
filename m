Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80893C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwd0-0001H6-Ud; Tue, 11 Jun 2024 04:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGwcv-0001GJ-LQ; Tue, 11 Jun 2024 04:13:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGwct-0001H5-WD; Tue, 11 Jun 2024 04:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0Lb1vu7uH/FYbA/G2e8Dch1YpR1s8lYg2/sDqRpxwt8=; b=Ll5pQ+MCJ/pYngcZcXM1cs+YPZ
 9HYYTgXvYqq9/wTcGWtMvOO9ruK8OubUd+2NIgkWrV3yejhDX/+AOYwgoUCb4ggmGY84uDqUudspb
 1NlSMJYOdc6gTj3YG4Gd50Mvm/3BWL/D2BeEDyL4btDa9PxaQgxzt/k8mKolzVSYh9EL4gPUVtMZq
 SeNTthrvtPfAaDv5UPGvt9/ph9Msj8fnfVF0bd7J6GMigBvJaEor9TVCvDrR+34HRnncEV2nqb2xs
 Rlo6c0xUiUqUHG97d7HLXWC1mcHZPbkguGwolmFmp2JDJPpfax7/2KAnZG30Tu9LfEHX2piJ1TSdJ
 Kt9AH7j9bhAhxlH4csqvof60W0g5CMXo8xtl8JkgRG9ve6A/VTUUh13Y0NTGhaBtn6IlUifFmUYke
 aYl89fnUxVI9DHS4knQWEidAA9+KmnBAV75geJkb698r65qp9NPVxrQlvBsEolzjfUz9mT9xWw/x+
 FBsx6MaVj0I03VCm3KxfJTXMNP/LYL1K1raGgW+BZeO3zf1itT0mO2Kc/4/8WjJgOhMilmwxnqVCP
 WkVGei9gNU7ZsisNAkg0Ba04M22G/C9D2b3I++t7g/TMt2s35s8tky98ArMOQ1C15Hmsb10x9V/6Q
 zWsiZb8ZSuKUgu2vCkt1N9vDFXR4wHcny3pf30AD4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGwbY-00066H-IG; Tue, 11 Jun 2024 09:11:48 +0100
Message-ID: <887ef788-53b2-469d-bb36-d4a9ea795a38@ilande.co.uk>
Date: Tue, 11 Jun 2024 09:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240610150758.2827-1-philmd@linaro.org>
 <87h6e0uizr.fsf@pond.sub.org> <ZmgDXJ7Zt9AI2Z_7@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <ZmgDXJ7Zt9AI2Z_7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Examining device state via monitor for debugging
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/06/2024 08:57, Daniel P. Berrangé wrote:

> On Tue, Jun 11, 2024 at 07:49:12AM +0200, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Officialise the QMP command, use the existing
>>> hmp_info_human_readable_text() helper.
>>
>> I'm not sure "officialise" is a word :)
>>
>> Taking a step back...  "info via" and its new QMP counterpart
>> x-query-mos6522-devices dump device state.  I understand why examining
>> device state via monitor can be useful for debugging.  However, we have
>> more than 2000 devices in the tree.  Clearly, we don't want 2000 device
>> state queries.  Not even 100.  Could we have more generic means instead?
>>
>> We could use QOM (read-only) properties to expose device state.
>>
>> If we use one QOM property per "thing", examining device state becomes
>> quite tedious.  Also, you'd have to stop the guest to get a consistent
>> view, and adding lots of QOM properties bloats the code.
>>
>> If we use a single, object-valued property for the entire state, we get
>> to define the objects in QAPI.  Differently tedious, and bloats the
>> generated code.
>>
>> We could use a single string-valued property.  Too much of an abuse of
>> QOM?
> 
> Yeah, I'd suggest we just keep it dumb and free form, adding a
> callback like this to the QOM base class:
> 
>    HumanReadableText (*debug_state)(Error **errp);

I think that's a little bit too restrictive: certainly I can see the need for 
allowing parameters for the output to be customised, and there may also be cases 
where a device may want to register more than one debug (or monitor) command.

Currently I quite like Manos' solution since it allows a MonitorInterface to be 
defined, and that could have separate methods for registering both "info" and "debug" 
commands. Longer term this could allow for e.g. TYPE_TCG_ACCEL to register "info jit" 
and devices can add whatever debug monitor commands they need.


ATB,

Mark.


