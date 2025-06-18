Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC644C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRo9G-0001Dv-10; Wed, 18 Jun 2025 04:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRo9D-0001Df-8Q
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRo9A-0006Z9-DS
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750235270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+7qm2QOt4HDeG9l0wtWmNg5ozuJh8NqO4G3QAepq4g=;
 b=imBBUp0y/AxArVEXih4VSYIeZBd2Ok/1eYUqvvoEJufP/NO0dO+JCMd3C4Irx4Lm2QlKsp
 WWPfCzO0ncIYmmJ21AXccLGqfaae7y+bZiYYs2fWTxoN8G5zWc0HDjpu1Q/3orHCm9MuHm
 Dt5Rx3Y5WX+hCWS9DFC2oPieBoiH9m8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-3S0ys-XfOgWD9IIYT4XCeQ-1; Wed, 18 Jun 2025 04:27:48 -0400
X-MC-Unique: 3S0ys-XfOgWD9IIYT4XCeQ-1
X-Mimecast-MFC-AGG-ID: 3S0ys-XfOgWD9IIYT4XCeQ_1750235267
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so236413f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 01:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750235267; x=1750840067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+7qm2QOt4HDeG9l0wtWmNg5ozuJh8NqO4G3QAepq4g=;
 b=iZXLS29jAD6twdK+52RmhOULQzOAQf9HQqLajnGG3/4a64KnET9/a57IOnNYGlRPK8
 Ie2iQG0Y+ikfzxrE+9OPatcxUu6oJWj1P+58V2PVw2uvm5bOxn0g0n5qImgFq6uwMZuO
 oORkdhxw0zZRvzvqjECIkS6hDq//ImQPoc18FhqkXzyBhv+71oD/JJDtGpFN5qgI6hL3
 qPR8Zy/YEarplCJf4Dv16B0Vkd1ClGBcdbO/KGtE49d4SQKnMi20nUDra51hMYA0AL9e
 tabD2Vo1wp0mldKPGDEYWhknSDzY1ZPs8YxeRInY/0yTrCQSIV/2vxxGBviOZjFRK6zK
 rIZA==
X-Gm-Message-State: AOJu0YyDM7xU/TYdGeNgdIXMTs6CzZPqIzbmekqduvP5zPQERRuApPPF
 d6oeiqfLjM3lVs3TUNTL5Pd2UXXsHeH2PxpIF2JJupIdDGLunhUy9TEh62aUZpiH3Mp0MHGfGJG
 CLxwaJyhs5Qax6mynxZbQMyGjw5kUFBisIhEIs0E3BeiG64AdsI9puHCrXRZa50CaFZ7CgGU09E
 MsHT5LEtnHnPUuVxSvW295qdhEdqganQU=
X-Gm-Gg: ASbGncvAHgofpEiuQN1s28m7FmnovWXJLFqUvsaPXLAWW5moPZXWToCvTdZ65ZjKBrw
 So6m8uCbk++jmZEWY0GpFYO1w+ZvGkIoyYofBdY7Bn4xSEcIqOFhPHB8CAkY6BvdQ2Ae1QBJVtq
 uhmzQ=
X-Received: by 2002:a05:6000:386:b0:3a5:7944:c9f with SMTP id
 ffacd0b85a97d-3a58e13fb12mr1354312f8f.2.1750235267364; 
 Wed, 18 Jun 2025 01:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsV3u1ClSgt8OoUXKBlV7V9QDsSQHpYeFYOE2GMyGGQsALPPKSFqZ4mKstFH7U+TB6Sr7fSr1TtpxZgzTM4OY=
X-Received: by 2002:a05:6000:386:b0:3a5:7944:c9f with SMTP id
 ffacd0b85a97d-3a58e13fb12mr1354282f8f.2.1750235266692; Wed, 18 Jun 2025
 01:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <875xgu95a0.fsf@pond.sub.org>
In-Reply-To: <875xgu95a0.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Jun 2025 10:27:35 +0200
X-Gm-Features: Ac12FXyDE8ZZGtQt4QQZvafhgjJsN8mxstQmRlx91AhrC-E6Bvl_1kbSsLYxPv4
Message-ID: <CABgObfZgp82HKSv3-CFL-MD-86LGQQGcAPYi83Q8Qhq_HbiORQ@mail.gmail.com>
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-rust@nongnu.org, Martin Kletzander <mkletzan@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000584b660637d467ed"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000584b660637d467ed
Content-Type: text/plain; charset="UTF-8"

Il mar 17 giu 2025, 09:49 Markus Armbruster <armbru@redhat.com> ha scritto:

> pylint isn't happy with the new module:
>

Fixed, will post a new version.

Can I pick your brain on whether to focus on Rust<->QObject conversion or
give the Rust structs the full visitor treatment? (See other messages in
reply to the cover letter).

Paolo


************* Module qapi.rs_types
> scripts/qapi/rs_types.py:286:4: W0237: Parameter 'branches' has been
> renamed to 'variants' in overriding
> 'QAPISchemaGenRsTypeVisitor.visit_object_type' method (arguments-renamed)
> scripts/qapi/rs_types.py:307:4: W0237: Parameter 'alternatives' has been
> renamed to 'variants' in overriding
> 'QAPISchemaGenRsTypeVisitor.visit_alternate_type' method (arguments-renamed)
> scripts/qapi/rs_types.py:316:67: W0613: Unused argument 'builtins'
> (unused-argument)
> scripts/qapi/rs_types.py:9:0: W0611: Unused POINTER_SUFFIX imported from
> common (unused-import)
> scripts/qapi/rs_types.py:10:0: W0611: Unused rs_ctype_parse imported from
> rs (unused-import)
> scripts/qapi/rs_types.py:18:0: W0611: Unused QAPISchemaEnumType imported
> from schema (unused-import)
> scripts/qapi/rs_types.py:18:0: W0611: Unused QAPISchemaType imported from
> schema (unused-import)
>
>
> Might be too early to bother with the type hints, but here goes anyway:
>
> $ mypy scripts/qapi-gen.py
> scripts/qapi/schema.py:70: error: Argument 1 to "rsgen_ifcond" has
> incompatible type "str | dict[str, object] | None"; expected "str |
> dict[str, Any]"  [arg-type]
> scripts/qapi/rs.py:99: error: Incompatible types in assignment (expression
> has type "str | None", variable has type "dict[str, str]")  [assignment]
> scripts/qapi/rs.py:103: error: Unsupported left operand type for +
> ("None")  [operator]
> scripts/qapi/rs.py:103: note: Left operand is of type "str | None"
> scripts/qapi/rs.py:103: error: Incompatible types in assignment
> (expression has type "str | Any", variable has type "dict[str, str]")
> [assignment]
> scripts/qapi/rs.py:106: error: Incompatible types in assignment
> (expression has type "str", variable has type "dict[str, str]")
> [assignment]
> scripts/qapi/rs.py:108: error: Incompatible types in assignment
> (expression has type "str", variable has type "dict[str, str]")
> [assignment]
> scripts/qapi/rs.py:110: error: Incompatible types in assignment
> (expression has type "str", variable has type "dict[str, str]")
> [assignment]
> scripts/qapi/rs.py:111: error: Incompatible return value type (got
> "dict[str, str]", expected "str")  [return-value]
> scripts/qapi/rs_types.py:47: error: Item "None" of "QAPISchemaVariants |
> None" has no attribute "tag_member"  [union-attr]
> scripts/qapi/rs_types.py:49: error: Item "None" of "QAPISchemaVariants |
> None" has no attribute "variants"  [union-attr]
> scripts/qapi/rs_types.py:84: error: Item "None" of "QAPISchemaVariants |
> None" has no attribute "variants"  [union-attr]
> scripts/qapi/rs_types.py:116: error: Incompatible default for argument
> "exclude" (default has type "None", argument has type "list[str]")
> [assignment]
> scripts/qapi/rs_types.py:116: note: PEP 484 prohibits implicit Optional.
> Accordingly, mypy has changed its default to no_implicit_optional=True
> scripts/qapi/rs_types.py:116: note: Use
> https://github.com/hauntsaninja/no_implicit_optional to automatically
> upgrade your codebase
> scripts/qapi/rs_types.py:118: error: Incompatible return value type (got
> "list[str]", expected "str")  [return-value]
> scripts/qapi/rs_types.py:251: error: Item "None" of "QAPISchemaVariants |
> None" has no attribute "variants"  [union-attr]
> scripts/qapi/rs_types.py:309: error: Argument 2 of "visit_alternate_type"
> is incompatible with supertype "QAPISchemaVisitor"; supertype defines the
> argument type as "QAPISourceInfo | None"  [override]
> scripts/qapi/rs_types.py:309: note: This violates the Liskov substitution
> principle
> scripts/qapi/rs_types.py:309: note: See
> https://mypy.readthedocs.io/en/stable/common_issues.html#incompatible-overrides
> Found 15 errors in 3 files (checked 1 source file)
>
>

--000000000000584b660637d467ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 17 giu 2025, 09:49 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
pylint isn&#39;t happy with the new module:<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Fixed, will post a new version.=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Can I pick your b=
rain on whether to focus on Rust&lt;-&gt;QObject conversion or give the Rus=
t structs the full visitor treatment? (See other messages in reply to the c=
over letter).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
************* Module qapi.rs_types<br>
scripts/qapi/rs_types.py:286:4: W0237: Parameter &#39;branches&#39; has bee=
n renamed to &#39;variants&#39; in overriding &#39;QAPISchemaGenRsTypeVisit=
or.visit_object_type&#39; method (arguments-renamed)<br>
scripts/qapi/rs_types.py:307:4: W0237: Parameter &#39;alternatives&#39; has=
 been renamed to &#39;variants&#39; in overriding &#39;QAPISchemaGenRsTypeV=
isitor.visit_alternate_type&#39; method (arguments-renamed)<br>
scripts/qapi/rs_types.py:316:67: W0613: Unused argument &#39;builtins&#39; =
(unused-argument)<br>
scripts/qapi/rs_types.py:9:0: W0611: Unused POINTER_SUFFIX imported from co=
mmon (unused-import)<br>
scripts/qapi/rs_types.py:10:0: W0611: Unused rs_ctype_parse imported from r=
s (unused-import)<br>
scripts/qapi/rs_types.py:18:0: W0611: Unused QAPISchemaEnumType imported fr=
om schema (unused-import)<br>
scripts/qapi/rs_types.py:18:0: W0611: Unused QAPISchemaType imported from s=
chema (unused-import)<br>
<br>
<br>
Might be too early to bother with the type hints, but here goes anyway:<br>
<br>
$ mypy scripts/qapi-gen.py <br>
scripts/qapi/schema.py:70: error: Argument 1 to &quot;rsgen_ifcond&quot; ha=
s incompatible type &quot;str | dict[str, object] | None&quot;; expected &q=
uot;str | dict[str, Any]&quot;=C2=A0 [arg-type]<br>
scripts/qapi/rs.py:99: error: Incompatible types in assignment (expression =
has type &quot;str | None&quot;, variable has type &quot;dict[str, str]&quo=
t;)=C2=A0 [assignment]<br>
scripts/qapi/rs.py:103: error: Unsupported left operand type for + (&quot;N=
one&quot;)=C2=A0 [operator]<br>
scripts/qapi/rs.py:103: note: Left operand is of type &quot;str | None&quot=
;<br>
scripts/qapi/rs.py:103: error: Incompatible types in assignment (expression=
 has type &quot;str | Any&quot;, variable has type &quot;dict[str, str]&quo=
t;)=C2=A0 [assignment]<br>
scripts/qapi/rs.py:106: error: Incompatible types in assignment (expression=
 has type &quot;str&quot;, variable has type &quot;dict[str, str]&quot;)=C2=
=A0 [assignment]<br>
scripts/qapi/rs.py:108: error: Incompatible types in assignment (expression=
 has type &quot;str&quot;, variable has type &quot;dict[str, str]&quot;)=C2=
=A0 [assignment]<br>
scripts/qapi/rs.py:110: error: Incompatible types in assignment (expression=
 has type &quot;str&quot;, variable has type &quot;dict[str, str]&quot;)=C2=
=A0 [assignment]<br>
scripts/qapi/rs.py:111: error: Incompatible return value type (got &quot;di=
ct[str, str]&quot;, expected &quot;str&quot;)=C2=A0 [return-value]<br>
scripts/qapi/rs_types.py:47: error: Item &quot;None&quot; of &quot;QAPISche=
maVariants | None&quot; has no attribute &quot;tag_member&quot;=C2=A0 [unio=
n-attr]<br>
scripts/qapi/rs_types.py:49: error: Item &quot;None&quot; of &quot;QAPISche=
maVariants | None&quot; has no attribute &quot;variants&quot;=C2=A0 [union-=
attr]<br>
scripts/qapi/rs_types.py:84: error: Item &quot;None&quot; of &quot;QAPISche=
maVariants | None&quot; has no attribute &quot;variants&quot;=C2=A0 [union-=
attr]<br>
scripts/qapi/rs_types.py:116: error: Incompatible default for argument &quo=
t;exclude&quot; (default has type &quot;None&quot;, argument has type &quot=
;list[str]&quot;)=C2=A0 [assignment]<br>
scripts/qapi/rs_types.py:116: note: PEP 484 prohibits implicit Optional. Ac=
cordingly, mypy has changed its default to no_implicit_optional=3DTrue<br>
scripts/qapi/rs_types.py:116: note: Use <a href=3D"https://github.com/haunt=
saninja/no_implicit_optional" rel=3D"noreferrer noreferrer" target=3D"_blan=
k">https://github.com/hauntsaninja/no_implicit_optional</a> to automaticall=
y upgrade your codebase<br>
scripts/qapi/rs_types.py:118: error: Incompatible return value type (got &q=
uot;list[str]&quot;, expected &quot;str&quot;)=C2=A0 [return-value]<br>
scripts/qapi/rs_types.py:251: error: Item &quot;None&quot; of &quot;QAPISch=
emaVariants | None&quot; has no attribute &quot;variants&quot;=C2=A0 [union=
-attr]<br>
scripts/qapi/rs_types.py:309: error: Argument 2 of &quot;visit_alternate_ty=
pe&quot; is incompatible with supertype &quot;QAPISchemaVisitor&quot;; supe=
rtype defines the argument type as &quot;QAPISourceInfo | None&quot;=C2=A0 =
[override]<br>
scripts/qapi/rs_types.py:309: note: This violates the Liskov substitution p=
rinciple<br>
scripts/qapi/rs_types.py:309: note: See <a href=3D"https://mypy.readthedocs=
.io/en/stable/common_issues.html#incompatible-overrides" rel=3D"noreferrer =
noreferrer" target=3D"_blank">https://mypy.readthedocs.io/en/stable/common_=
issues.html#incompatible-overrides</a><br>
Found 15 errors in 3 files (checked 1 source file)<br>
<br>
</blockquote></div></div></div>

--000000000000584b660637d467ed--


