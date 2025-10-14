Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2010CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hgt-0002pp-PN; Tue, 14 Oct 2025 12:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v8hgk-0002pT-0D
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:15:54 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v8hgf-0006Vt-MG
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:15:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-33292adb180so5389317a91.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760458542; x=1761063342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0x5mvdsciU8XlM7tsgF1SHaF5LXB6iM8X1i2eTLCID8=;
 b=h0TTB10FJ7KtMqgM4wJ3XWjkxpKN0zCfSILBh4K8cYC2d2/8MHANgq3c3yZqCN0hqY
 ET/J76NwnPJSobU6nCci92QYm43Yp9CgFrZiButBHRbZPqdCPAj8lnkw6qLSSoWby1QT
 rpSbzICS+10BAfum20fttm/lqB/S+IlMmPGNlHd617OaGcXEZr/PEdVlrdFlFROR2fv3
 0Q0z3eJ4lDYYjawUTWo7CaliEBWJOX1S7z0Dl9FfCjE3XmClSNXk02MIFJfBGDid1vc1
 uWe83c5as6GePhsY6YAI8tR3vgMhPEmtrfnOqOBJvtVYOml94B4DbMrKGo0CLcTZUyGK
 3xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760458542; x=1761063342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0x5mvdsciU8XlM7tsgF1SHaF5LXB6iM8X1i2eTLCID8=;
 b=AKQXw7nx8HDb1HdupJt0jkSN16nWTo/TnYFVP26js4QY3oKi3aRMSVJ7J/bEQSBocb
 zMTwY+s5QSc5E09snq4rWIymaRIncLW8LkmIMr9WEQd76iEw1Gu6U2Mp4xQKbhnyf0GN
 FwCLtxkXzpyXV8rr1iCnliR0MgqA2FGWVGTFNH9YG9HE1pJcJWUpi8zhmOwhurN+mW9a
 JJglJvkaoOaFarkLvoGWL0cZ5wx51as8cwrEfOZDTyksZWmOpPkZKSMgh5mEsYR320yl
 NP3F/R60MmCN6yO7ipswWgCcZ256SFIoo6JtE5PkPkMiywqe1ACzNrPc1SuRUi/o6lZQ
 UKNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPqHe/HJlZU3Ar9Tlg2hv5aLGMtV5uxn0NcRAdX5IdFO4Rx6du+y4JU4/Pnc9IMdmAakgd+v8OFH0+@nongnu.org
X-Gm-Message-State: AOJu0Yzm0qLRFjuZw6c1YrTsxdi2vB7B8wmbV2e38SUs6y6ER7eBOE2J
 7vbTHTMeF1hX5ZcHXU5LWiN5IJUI7Yd46CgBgcMA67/qZoGmtfdDB3Dodvd8p1e1kB0=
X-Gm-Gg: ASbGncvkWIvmyUXVDUPF6HsrkOGoppt0oZ6GPDE0KQXJ4Wfg744PbOLq1yOR7hwoX6x
 z5v+Pvkyg7t84eFDa/x8ZHpKQ++G8+VmZLZHwDet+/FsrAbOJf85lZYDWmpwuWmDWjAr8XE/bZ1
 U3UJ6v04MaqPqykYEx8Ysbwlk97rWdtnfnUfMjj7j1VJ/r1lI5ooID4xKEHAX7p9DP09906kM7p
 x2WsmaSlhyT/nkWzSt8MgPbaL0wCFi0AJSw+73LAOzLgDWxTxGHZpM6sHEhGb/AMdZrE4T+Jd/+
 g66bsu8xOwPweZqtordqCue5POqBBdUu1FP3PJ2pLUPiXwQCqlpJV59hCb3W3STmPUgV0HaT+43
 0a4gkHe+G3F/lT6v1MExv5+PFyS8Ecc9TKo4eI17C1JmuV3v1M7QMdozsyUwma2FWKIC0QeLo1A
 ksoha3gP6F+IkXEh9sEfn1n1s=
X-Google-Smtp-Source: AGHT+IEbVRRXuBQWjmoG/NyuSn+6xWahftxSApIz9qb6uBh+i/FpMzla3L2aq0YBZZRXWQWQFs+f1g==
X-Received: by 2002:a17:903:a90:b0:27e:f201:ec90 with SMTP id
 d9443c01a7336-29027264d78mr319271305ad.25.1760458542502; 
 Tue, 14 Oct 2025 09:15:42 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:1d95:80a1:93a2:fc08:86bf?
 ([2804:7f0:b401:1d95:80a1:93a2:fc08:86bf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de6c88sm169912465ad.17.2025.10.14.09.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 09:15:42 -0700 (PDT)
Message-ID: <e280b52d-7fab-4e9f-84f4-a5862ce7284e@linaro.org>
Date: Tue, 14 Oct 2025 13:15:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
 <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
 <e3314d25-dd8a-46a9-bbfc-44fba387099a@linaro.org>
 <CAFEAcA_OLA=Ct7wFHwnfixrYofjyMDuw_5ViNb7Yxu43B12szQ@mail.gmail.com>
 <ca74ac20-f510-4c78-8f3b-85a551841041@linaro.org>
 <CAFEAcA9MjN3q06COn=_==v+zFt06Qtp9WEy7+yx2JO_L17StCQ@mail.gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <CAFEAcA9MjN3q06COn=_==v+zFt06Qtp9WEy7+yx2JO_L17StCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Peter,

On 10/14/25 12:28, Peter Maydell wrote:
> On Tue, 14 Oct 2025 at 16:24, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 10/12/25 16:58, Peter Maydell wrote:
>>> On Fri, 10 Oct 2025 at 20:59, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 10/10/25 16:03, Richard Henderson wrote:
>>>>> On 10/10/25 06:04, Peter Maydell wrote:
>>>>>> ----------------------------------------------------------------
>>>>>> target-arm queue:
>>>>>>     * Implement FEAT_GCS
>>>>>>     * Implement FEAT_MEC
>>>>>
>>>>> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.
>>>>
>>>> Could somebody give me access to https://wiki.qemu.org/ChangeLog/10.2, please?
>>>
>>> It should be accessible to anybody with a wiki account, I think.
>>>
>>> (I have already updated it per this pullreq's changes; let me
>>> know if I missed anything.)
>>
>> It's missing FEAT_MEC in the list.
> 
> ...and also FEAT_GCS : looks like I didn't update the changelog
> at all for this pullreq. Either I was confusing it with
> some other pullreq, or else I failed to actually save my
> changes or something.
> 
>> But let me add it so I can test my access to the Wiki pages.
> 
> Sure -- please add both FEAT_MEC and FEAT_GCS.

Ok! ;)


Cheers,
Gustavo

