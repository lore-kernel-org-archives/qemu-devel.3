Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FB2EFD204
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9iq-0002P5-D4; Wed, 25 Feb 2026 02:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vv9ih-0002OC-5i
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:54:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vv9if-0008Bi-JR
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772006044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kck12/sq6ZCjRfMVugq1HOG2Mws78HAt4wd2MwchXOA=;
 b=HjQKr2vtED8EDdCtzstbeUmrPR1UqGws6K2gTJsKNv87RHjwY1jNq+BfNItUcBwPg9IJq+
 Y1TIKPNukYNFCpaQEePoZezv1sq+cAMtYFlKf+7L/aNf/0iTv0oHumMme39JHwg1pOGM/j
 tDTxQRFxEM0ZNt5sBP/K1aLUM0xz/gE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160--m3uGS4rPCeUY7MMfiPBMA-1; Wed, 25 Feb 2026 02:54:01 -0500
X-MC-Unique: -m3uGS4rPCeUY7MMfiPBMA-1
X-Mimecast-MFC-AGG-ID: -m3uGS4rPCeUY7MMfiPBMA_1772006041
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b8fa5744b82so176977366b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 23:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772006039; x=1772610839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kck12/sq6ZCjRfMVugq1HOG2Mws78HAt4wd2MwchXOA=;
 b=SUb9lPhIAShufeu0Ox8f4PyU33l96vn3jCsAWrrtfpvjqEn3eKanfwLsU2clvgS2Jm
 L9qBS3KVcKcTGneP4/pw5OkhAqnid5iJfRhaBR5cg9d+9ws6GgKTofke7qiA7cQhqdUE
 UhdSREf7SkmfsvMJgOPAk95PN/ezH5Pt/AACuzx0wt4qXQGUFy2CsoKEl0BqafO0rX5d
 pHHiYelqtuTQpzH5vEa/mhPp6ncqPEndS6r22Jvo+QcdaSh89aPvlVeaLsG+6a/zHcBE
 W/b45fm/n0ezieVqAejpspMwHo8+wXrdsaIf5qfsbHDG32Q4LlIvWMbxk9P4q7LpOsXR
 0d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772006039; x=1772610839;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kck12/sq6ZCjRfMVugq1HOG2Mws78HAt4wd2MwchXOA=;
 b=eRIC3DvW+2r9XnFlfKIhUsTdXWfvBsiktFwwJqHrrCaX3XTtNaBz2RVxcZZ27/QWEt
 I5PMACpH84pLdtgfkPtqhzXtLgxiRWQji8jjLV1xc4KefyJK3osxgXIWxIcguX3AWxND
 3uxIv2BubPFtz9oq/aYGMwlazpA3jvFdVFK+DwoXPIIVcF7l8coQ7CJV6SqD5nlOhIP4
 IyhtiHeyZ41VYWRRSzoBriXNJCw0zmCnjXLlaowprcIKRQdTtA6goPApCA+g0oJAcV8i
 6gaeGzzFxISQrENucItB9nmZSONF9mIEfKw/mshb+dw+2bL+MyTOuR4MT/QQ0cTAtCWD
 s6sw==
X-Gm-Message-State: AOJu0YycCSgAQlYiH9aspn69svI1RzNJR7nbYBzP/PzehggoyubbV8Di
 zTm6IOROxurSRc8+j6gl8g709ZGhN1p2ygYvuObNT+t2qVbNqw1UANFO8e2P+T1jurEYhNtiZa7
 eKYLzUDKl5rL0zgOQAEt8OHXzn/6KIdGQqhhpFpnSHsDaOZ1c5YpMsHz2F3ljCM69
X-Gm-Gg: ATEYQzzplhH0qT3Ao5UhsnzAIeyi/Ywf0jaE/oabsS3uY2hsrvOqwMBTSxBc51vx8yF
 AftbPoM6iIWzSx3wgFeBLZ6NkFPzbQvYaXzFWV0SLIaO6CwKXJbIPvDfYtenFLeZwtgeSRpeC2T
 79JZaIaNFxubE+cU4i2Bdcq400I2rXvB/P8/x64gXm1T+vy8dJ4mv1eRrrzx4JKBolWZDP4xxzF
 oVKLBWJQ9V/1UI2EpBWJ/5IJ7ob5YeVO6VJodctOxRbPB1jfaxzpc7fY5Fizf/gw9cxisaR6dAx
 0eowHnWwSloloAA12P8yO225n+8V547ysY0J8BCKCLyu2pgYgm46xOH55YRHoZ43wmvC84WvsbX
 jrbCkv3VQUZ/nALN2u1lQF1N2gpPO1i/2PzRze+oE5YFVfzfFHnNfXcF1zw/dSCizL0IjRgsMd6
 Lr2WS6vSJYpBAYPUmJAHMaumDcCkY=
X-Received: by 2002:a17:907:7fa6:b0:b88:5158:d106 with SMTP id
 a640c23a62f3a-b9341e8272emr92850066b.52.1772006039387; 
 Tue, 24 Feb 2026 23:53:59 -0800 (PST)
X-Received: by 2002:a17:907:7fa6:b0:b88:5158:d106 with SMTP id
 a640c23a62f3a-b9341e8272emr92848266b.52.1772006038890; 
 Tue, 24 Feb 2026 23:53:58 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9348d6c5c3sm12107166b.11.2026.02.24.23.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 23:53:58 -0800 (PST)
Message-ID: <3d328c28-5640-4489-aab3-51838a62065f@redhat.com>
Date: Wed, 25 Feb 2026 08:53:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] scripts/qapi: add QAPISchemaIfCond.rsgen()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-10-pbonzini@redhat.com> <87pl5txqr3.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87pl5txqr3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/25/26 07:48, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Generate Rust #[cfg(...)] guards from QAPI 'if' conditions; it
>> turns out that they are very similar, with both of them using
>> not/any/all, so just walk the tree.
>>
>> The next commit will put it to use.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lureau@redhat.com
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   scripts/qapi/common.py | 19 +++++++++++++++++++
>>   scripts/qapi/schema.py |  4 ++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index d7c8aa3365c..14d5dd259c4 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -199,6 +199,25 @@ def guardend(name: str) -> str:
>>                    name=c_fname(name).upper())
>>   
>>   
>> +def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
>> +
>> +    def cfg(ifcond: Union[str, Dict[str, Any]]) -> str:
>> +        if isinstance(ifcond, str):
>> +            return ifcond
>> +        assert isinstance(ifcond, dict) and len(ifcond) == 1
>> +        if 'not' in ifcond:
>> +            oper = 'not'
>> +            arg = cfg(ifcond['not'])
>> +        else:
>> +            oper, operands = next(iter(ifcond.items()))
>> +            arg = ', '.join([cfg(c) for c in operands])
>> +        return f'{oper}({arg})'
>> +
>> +    if not ifcond:
>> +        return ''
>> +    return '#[cfg(%s)]' % cfg(ifcond)
>> +
>> +
> 
> Why not reuse the existing tree walker?  See appended diff.

I think it won't work due to need_parens?  gen_ifcond is really designed 
for infix notation, I have no doubt that it *can* be made to work (for 
example pass 'all' and 'any' and prefix them after processing 
need_parens), but there is little duplication in the code other than

         if isinstance(ifcond, str):
             return cond_fmt % ifcond
         assert isinstance(ifcond, dict) and len(ifcond) == 1

because unary and n-ary operators in prefix notation are quite similar, 
unlike unary and binary operators in infix notation.

Paolo


