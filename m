Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF58C3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9W87-0005q7-9S; Mon, 28 Apr 2025 17:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9W84-0005pe-He
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:35:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9W82-0003l6-Es
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:35:08 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22435603572so60757825ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876104; x=1746480904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LQkZKCuM54yFZ3Wtk8xnIXSl1oXhfVhonQBaiyWdn1A=;
 b=qGyKlkbi1DMvCmJ3bH55LH/03Unfh7Gp5P0HvGpp5qqEvOwD8KZ5huSrKsUXA5tIr6
 1iMmFGVtVx32YMS9yQoR0kIWOEA5e5zmVMPctCm0Xf3sg5HHM+t0MPPc9v7m/LZyol+x
 dJee+lzkFekraNdLaPB3XmN97OeEG+I25OqPZzlJ3Yl65QzKQUE2mUu68Xpfo7556Kp1
 GkkozZsSlJBLHp0FCeEHY/veMwOTuPdzgysL0BkJWAKjX84bm6JiKmq7kvzI9fDkFlVy
 +YSG0pxNjekZ4lQITP/xnX5SJ9NKX0e5gZiMtjX8/sOBu+/GomokaHc45RW4t4Xln0b3
 Wc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876104; x=1746480904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LQkZKCuM54yFZ3Wtk8xnIXSl1oXhfVhonQBaiyWdn1A=;
 b=Y1+ndypHFSCMxb1VRNhfxnkVnTnPZRa+KYKjLSsl/dj5JkQnSYik85lgZ1+o9kxT4Y
 DWmtQhd9U04suIEPrd90/dVavo8dHf1yLDGTUIOrGGJujXv2STNo/6Xeb/HVlsAxopOH
 8X/QQjYLVFpFrGRSgsYj3UbJnbLZBO0TfyAphEsyJui4A+OK4dFJ+0FY6H/MUyDS7tzW
 4Yuyq+7cyoSndQJ9WuN0nJH7OQvsNRJi9kz+Jn4HFn+sMa2JkpCqe4sBWsIIVwleFlA6
 2T3LF95cyZG9mXNfK07qxTLQfwkx+5hHXrultnWFV0jkvNpJBsWVfH3ePNUoksx9Diwm
 oiPQ==
X-Gm-Message-State: AOJu0YxMqNuK4PLObRHMzixxAGBy9THNM/qtyC7HtyLZhZKihgWmHOjy
 X0bdbjvz5w4il7pnm6VrfxJ3PaeQS99BJmY02E+dXqFW7he7kb7fkBqfEuxN/7E=
X-Gm-Gg: ASbGncvxhOflbYr1yCthucRQNHzqs3DmF2e5PxK/Qhlbk2ofocDR62ODg3dbeCc4Aut
 Qa2s4zqUCzZHtETeWCSDv4pjB97n2mSiwlDuMTf7reoaoGJHcejVUCWNG1bdX6yW8lQbDceqnWn
 5YvXdyLGsWL7zd8qFIP4yLKyab3jlb+jFmMcDHUpoFjhox/8dnz8TOE0RumgscSkDYp5OF7/vGv
 aN5Y2FX5yC6T2OUeRbVxLl5Es66aB4NxiiWnKqA/yJt1nCLV1fDlXu91B0zF3HFZQN32Y1SsrBo
 A9yXqYWoJq6/8vlssiKtC9tRtM8BWI2N0QWkN5Ci1/5gzcvDNYnV+w==
X-Google-Smtp-Source: AGHT+IFopyHmH5tZhDeNpyYSe1TBWq3eJLMrtTg2/NTHYjhtsNv1vHCJ5UQw7NMX09+DKJIG/xz/4Q==
X-Received: by 2002:a17:903:1107:b0:224:191d:8a87 with SMTP id
 d9443c01a7336-22de5fdcd88mr15630935ad.26.1745876103874; 
 Mon, 28 Apr 2025 14:35:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76dffsm88199035ad.30.2025.04.28.14.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:35:03 -0700 (PDT)
Message-ID: <b0c22d97-3269-406a-b775-abc6470143e9@linaro.org>
Date: Mon, 28 Apr 2025 14:35:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <CAJSP0QUXuAUxMLOz5Zw1zwk0zwBRwuFM=qCufwf0TLr+w1YXvQ@mail.gmail.com>
 <1718b3de-9187-4fd0-87e7-ffe91393caf8@linaro.org>
 <CAJSP0QUKmWY0b9xxX5k-8iV=P4QC4EXdHdzF41LrA0AmRcse3A@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAJSP0QUKmWY0b9xxX5k-8iV=P4QC4EXdHdzF41LrA0AmRcse3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/28/25 12:54 PM, Stefan Hajnoczi wrote:
>> Sure.
>>
>> Maybe there is a misunderstanding, but at this point, we are not trying
>> to invent anything new. We are just looking for a way to build QAPI
>> generated code only once, so it's possible to link together object files
>> coming from two different targets.
>>
>> My mistake was to not mention introspection in the cover letter, but
>> thanks to Markus and Daniel, I understood the consequences of that, and
>> my position is to keep the current schema and serialization methods
>> *exactly* as they are, so consumers don't see any change. The only place
>> where we need to do changes are scripts/qapi and qapi/.
> 
> Okay, if this is just about QAPI for now then it's definitely too
> early to discuss packaging.
> 
> I'm still curious which specific use cases you have in mind?
> 

The (lenghty) cover letter tries to explain where we are going, and why 
this change is needed for QAPI.
If it's not clear, feel free to tell, I'll update this for v2.

> Stefan


