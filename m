Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE54C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 09:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWBjp-0005ZX-KX; Tue, 23 Jul 2024 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWBjn-0005Wt-Gb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 05:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWBjl-0004vV-B6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 05:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721726592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vSLt0ih/utlaqFeVq84GUq1D28QR559+/mo58QkwYb0=;
 b=JkK+gNYMnnqh9OUSgE4izib9oBioUnD/zgaGguWM3y/ZL2z/gNkkYwrIiMbdeSNLo8cwKR
 IdPS3J3n8wkKt3TR+d/zu04FZhmlS/IaxIxZhsqku4ECupc49pXmRPDwVtjSMtWl/ySMnQ
 IBSEpFlvwyAphryApfDKEJLJ20Yo7Zc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-zr2Xpn9jPReONq9LWxLWog-1; Tue, 23 Jul 2024 05:23:08 -0400
X-MC-Unique: zr2Xpn9jPReONq9LWxLWog-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36831948d94so2904441f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 02:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721726587; x=1722331387;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSLt0ih/utlaqFeVq84GUq1D28QR559+/mo58QkwYb0=;
 b=FkEifC7EoOv0sgNjarcwQpTmWSmPQL1KPM/oVc36MPKAw9WzHRAjtqhiQqYpKaquDF
 wK5wNki4nW8oQqWq6dMuPDHy9BVQzSO1kI5E/SzDFOiImxXYh4fVhacmtD+Pmsos6cUp
 SUS1+iL/NME7fcqtKpgMza2tiiKP9D7ZUcyZ7FvEg7Wz0npawc1UAE4mX30OxVQBhTME
 yXUCQ9tlBEpk716XbAMB6tu08aVdAXCLPouCpk5T6utyg+oHYWDjktA3//wlPXkYYBlF
 dBkGxmJQuR6z463HhQ+POXgluNeqsqCLx/E0ojIVjDQLq4/3UTfqx6YbSBPMXKqQz082
 leQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxQwgoXG1SX1oYgB4j5MgzBnlxExYIk1x1F9UMeQLQ+ygjVy3sZtT9K6osvFSE7CoR0cyZqAhumNX93JqGU39kWaXp9dY=
X-Gm-Message-State: AOJu0YxJI3eGD1HGO7H9LGEJQOHu82VYxt+/umee5CvZ2WSmE87yN6Mc
 e6kH04DGhNWbTe1ti4ziiZ08iNhklQf1jvSmhO2mIX+uwxx4jLork46zJTAcEYw2BsMo53gpJ/j
 Q54FJOvLetxdDjMe2A1WzMP+qQlIEyzsXC511q8mF2KH94VSYr7Kf
X-Received: by 2002:a5d:6d8a:0:b0:367:95e8:3aef with SMTP id
 ffacd0b85a97d-369bb2a1bcfmr7978966f8f.42.1721726587331; 
 Tue, 23 Jul 2024 02:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1QjpnmvTMi+lmP2sVQ/IZC2t2/DMaOUKmbKmsKMlILttODmtpHd4irBeYQqxP9yhHQNkoQQ==
X-Received: by 2002:a5d:6d8a:0:b0:367:95e8:3aef with SMTP id
 ffacd0b85a97d-369bb2a1bcfmr7978947f8f.42.1721726586861; 
 Tue, 23 Jul 2024 02:23:06 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-36.web.vodafone.de.
 [109.43.178.36]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ceccasm10818167f8f.81.2024.07.23.02.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 02:23:06 -0700 (PDT)
Message-ID: <58178bd0-4e7d-4770-aa54-5bd2811dcb39@redhat.com>
Date: Tue, 23 Jul 2024 11:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: Collin Walling <walling@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/07/2024 16.50, Collin Walling wrote:
> On 7/20/24 1:33 AM, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>>
>>> Currently, there is no way to execute the query-cpu-model-expansion
>>> command to retrieve a comprehenisve list of deprecated properties, as
>>> the result is dependent per-model. To enable this, the expansion output
>>> is modified as such:
>>>
>>> When reporting a "full" CPU model, show the *entire* list of deprecated
>>> properties regardless if they are supported on the model. A full
>>> expansion outputs all known CPU model properties anyway, so it makes
>>> sense to report all deprecated properties here too.
>>>
>>> This allows management apps to query a single model (e.g. host) to
>>> acquire the full list of deprecated properties.
>>>
>>> Additionally, when reporting a "static" CPU model, the command will
>>> only show deprecated properties that are a subset of the model's
>>> *enabled* properties. This is more accurate than how the query was
>>> handled before, which blindly reported deprecated properties that
>>> were never otherwise introduced for certain models.
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>
>>> Changelog:
>>>
>>>      v3
>>>      - Removed the 'note' and cleaned up documentation
>>>      - Revised commit message
>>>
>>>      v2
>>>      - Changed commit message
>>>      - Added documentation reflecting this change
>>>      - Made code changes that more accurately filter the deprecated
>>>          properties based on expansion type.  This change makes it
>>>          so that the deprecated-properties reported for a static model
>>>          expansion are a subset of the model's properties instead of
>>>          the model's full-definition properties.
>>>
>>> ---
>>>   qapi/machine-target.json         |  5 +++--
>>>   target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>>   2 files changed, 12 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index a8d9ec87f5..67086f006f 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -21,8 +21,9 @@
>>>   # @props: a dictionary of QOM properties to be applied
>>>   #
>>>   # @deprecated-props: a list of properties that are flagged as deprecated
>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>> -#     definition list of properties. (since 9.1)
>>> +#     by the CPU vendor.  These properties are either a subset of the
>>> +#     properties enabled on the CPU model, or a set of properties
>>> +#     deprecated across all models for the architecture.
>>
>>
>> When is it "a subset of the properties enabled on the CPU model", and
>> when is it "a set of properties deprecated across all models for the
>> architecture"?
...
> 
> Thanks for the feedback!  Pending your response to the above, I'll post
> a v4.

Since we've got soft-freeze for 9.1 today, I went ahead and put v3 into my 
last pull-request before the freeze period starts already. Please post the 
update to the comments as diff on top of that instead - updates to comments 
should still be fine for merging during the freeze period.

  Thanks,
   Thomas


