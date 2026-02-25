Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F572EFD204
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9po-0004Xo-77; Wed, 25 Feb 2026 03:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vv9pl-0004XG-Ja
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vv9ph-0000YU-O9
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772006480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fRQC/kwm9DBuuNV/g4K3AOseywUiLMUbpUq1B/QnJw=;
 b=ig6yM2xTdlmKDOxzBtZsatPldcRrXcP81fI9AhmQlkJBhOjAAoft9NWSRYxVi/YH33YxCI
 mCO6wDi2kwYvDVxIzNDbsrG2d33UE3eMkdWByKV5Hz39DP/0suGSXknGMxVDDeTcPJpcgx
 tfez1gSFuhoKDqjwEP05C7Rpl0VE6z0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-yWZGp_EdNiu-YHqxYVIBAg-1; Wed, 25 Feb 2026 03:01:18 -0500
X-MC-Unique: yWZGp_EdNiu-YHqxYVIBAg-1
X-Mimecast-MFC-AGG-ID: yWZGp_EdNiu-YHqxYVIBAg_1772006477
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483bcfdaf7dso9028365e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772006477; x=1772611277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fRQC/kwm9DBuuNV/g4K3AOseywUiLMUbpUq1B/QnJw=;
 b=QdgmQeNtL6QMVsfcUXF64L25IQbfj+4BfzRkJcfj7ARZwn6Q1sR4ybR6JQFhMnIJx+
 VP1HrvJrm4K+H1nfT0K1e/FG8tltThDZT3b0ruuF/MgI4ZVDgdR+EKk+0/MHLPmSktMO
 wmebyIiTrURv5f5eRHJC3uV5RyHC/+Pz1Bz/yqcUQqObYbB8C27NqyA9qBPp7MAU4vce
 Yr4uGsl9nNIqmbV89vZgmLJIi5fRstYCO4+Yr3KfDnUZqZ3sGAjPNQdgckE9g4Rry+VS
 3xbIq3f69qVw3rFwKE5rTBRK3nlPrFZSZEZ+VSpqrms4cUC8YIjA5rK0MovMK2hm2lt2
 O76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772006477; x=1772611277;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9fRQC/kwm9DBuuNV/g4K3AOseywUiLMUbpUq1B/QnJw=;
 b=Zb+zR1ZAvirenarB2yVo+d0MTxFI5syCH0GFbacLTTLkhXHl9nXfqZApPXgbYzcUeU
 zDi3ofJsyy+T2SKKRi51HNKx/vp9WvgdIm9d9IpcdazJQErf6pVCWJIWyRA7JHNX8EYM
 qan7/OnuYZgK8yEGSnBpiNOcOSS57ugNrDPcL7nsf1G8UkURurjEogzv1/HG4mh1w+86
 C26yS6gM0v0I8P1e1bWFc5Of+s8LMsWqxn6QaYuxkozYMQs3i7Qu66aEUKp9/sgJNktE
 Ze27G41rZdOBdBzOsQOr9zKhf0M1usWG6gk+gaxfUdtWdLEY75AWuBq1UzVKC+DOzUwa
 CfQw==
X-Gm-Message-State: AOJu0YxqY0axNEO68Ev5NYr0SwqWjdviaWoVMHfT7En4oFRH4tZEcwSV
 p/LKm5xWUlUx6SnRBSEzCyiJHQEd29B4s559S8aZqXcNcffdM0lAyAGj6XPrWkN3NzlnklCTIya
 /NnAV3V1Ns+jUGyT/duEVgK8Bdcisc0AM31neXsBLtwNS7cb9oOUXI9vT
X-Gm-Gg: ATEYQzz84DNezEnFdYDcEO7uki8z3PQiks51Y5Le9a9VY/fYq1TK+Tw5N6F8hi/7f8H
 oCwY2BLXIlnZSCW3Lfo4mI2VUGW+VzRIcZPcWRgaSicEw2kawovs42uTeNnJLgSZqOmOE/V0HYM
 iLrXO5qYsEAei/pih7PofaK6HJmdP9SfChbnYOd7NUCOcppKjotAAduI5zUZHxUa+LxSABHqryF
 tkCJwnOq2nzKhqVuc109jb+UoKQ8Wf9kdt0r/3XzIL561csZY3E038VX6cE5TfU4hedyaqMutJI
 z4DIeoWuxsD99lU1ESZER1st4IppmTbwyH2kmqc4SC1sAwZ4q/jroK0qd/K4lVFhWWeX3gmdtIp
 +5G35HtohlLXe96X+NNIa7TnnvPdP9FQj1fDqxsafkG7mpw9SDRttMWaxCXaS3PxoLxwtNYwJBC
 /s3Jj0iSLWdeB8D7Pq4szVj24G0S4=
X-Received: by 2002:a05:600c:8b44:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-483a95bebd8mr220916675e9.8.1772006477099; 
 Wed, 25 Feb 2026 00:01:17 -0800 (PST)
X-Received: by 2002:a05:600c:8b44:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-483a95bebd8mr220916285e9.8.1772006476616; 
 Wed, 25 Feb 2026 00:01:16 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bfb29715sm14429015e9.0.2026.02.25.00.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 00:01:15 -0800 (PST)
Message-ID: <21b5e0ec-d03d-4e39-a3bf-deada48243b7@redhat.com>
Date: Wed, 25 Feb 2026 09:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] scripts/qapi: add QAPISchemaType.is_predefined
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-11-pbonzini@redhat.com> <87bjhdxooi.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87bjhdxooi.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/25/26 08:33, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> It is impossible to call is_implicit on an enum type from the visitor, because
>> the QAPISchemaEnumType has already been exploded into its costituent fields.
> 
> constituent
> 
> Passing selected attributes instead of the entire object to its visitor
> method limits what the visitor can do.  This is both good and bad.
> We've run into "bad" a couple of times.  It's never been bad enough to
> change the interface, though.
> 
> Thoughts?

I think that applies here, is_predefined() is a reasonable addition.

>> The Rust backend is also not modular (yet?) so it is not possible to filter
>> out the builtin module;
> 
> Really?
> 
> The visitors are all based on QAPISchemaVisitor.  Protocol:
> 
>      .visit_begin()
>      for all modules:
>          .visit_module()
>          for all entities:
>              if .visit_needed():
>                  .visit_FOO()
>      .visit_end()
> 
> QAPISchemaModularCVisitor implements .visit_module() to generate code
> per module.  Its .write() skips builtin modules unless opt_builtins.

... because its .write() already builds multiple QAPIGen{C,H,Trace}, one 
per module.  Here instead there is just one QAPIGenRs.

Using multiple QAPIGenRs instances, one per module, would be hackish. 
I'd rather just go modular instead of that.  I can take a look, since 
this series will be (early) 11.1 material anyway.

Paolo

> QAPISchemaMonolithicCVisitor is oblivious of modules: it doesn't
> implement .visit_module(), and writes out everything.  This is fine,
> because we use it only to generate qapi-features.[ch] and
> qapi-introspect.[ch].  Generating the former has no need for recognizing
> the built-ins because there are no built-in features.  Generating the
> latter has no need because it treats built-in stuff exactly like
> user-defined stuff.
> 
> QAPISchemaRsVisitor [PATCH 12] also doesn't implement .visit_module().
> It uses QAPISchema.is_predefined(), defined in this patch, to skip
> built-in.  Could it rely on .visit_module() instead?
> 
>>                          add a way to query for implicit type names without
>> having the object itself.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   scripts/qapi/schema.py | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> index 848a7401251..15f5d97418f 100644
>> --- a/scripts/qapi/schema.py
>> +++ b/scripts/qapi/schema.py
>> @@ -1243,6 +1243,17 @@ def _def_builtin_type(
>>           # schema.
>>           self._make_array_type(name, None)
>>   
>> +    def is_predefined(self, name: str) -> bool:
>> +        # See QAPISchema._def_predefineds()
>> +        entity = self._entity_dict[name]
>> +        if isinstance(entity, QAPISchemaBuiltinType):
>> +            return True
>> +        if entity is self.the_empty_object_type:
>> +            return True
>> +        if name == 'QType':
>> +            return True
>> +        return False
>> +
>>       def _def_predefineds(self) -> None:
>>           for t in [('str',    'string',  'char' + POINTER_SUFFIX),
>>                     ('number', 'number',  'double'),
> 
> 
> 


