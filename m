Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5991C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 21:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRHRU-0007C4-R0; Mon, 16 Jun 2025 17:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRHRN-0007BP-Sz
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRHRK-0007ck-A0
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750109544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4t6LMhSW1GeanY0J4zTRn50DJbKVMzUSDICiTrenvn8=;
 b=SNRD1mb4eNfnOBjAAXo81c+hjW8uZWh27xskNZUmN0gh9DHIv4xYBllfuSArADpBZWZtcT
 t3C9f+4jV1NhEJpvk4Usb89Xrw4p4/EdfUlrQyzWevq+ROCHqhSftj8w5o2qsXmexcmZw7
 EsQA4ddX/AQG8LU50HVRTgkuFe16Wno=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673--hWWIr7YPDudhyVjNi76cA-1; Mon, 16 Jun 2025 17:32:23 -0400
X-MC-Unique: -hWWIr7YPDudhyVjNi76cA-1
X-Mimecast-MFC-AGG-ID: -hWWIr7YPDudhyVjNi76cA_1750109542
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4e2so1059453a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 14:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750109541; x=1750714341;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4t6LMhSW1GeanY0J4zTRn50DJbKVMzUSDICiTrenvn8=;
 b=kbgmutUk7S41KssXGDXVE5h2BOQJMNjXtSZTfiTSRaE9LIJcZGo/aSdUhuZafCVj0/
 wrJk8MzOuFdFEGx9Ugvl6jT1zw3uc7Y4ZbQHo6EtaInVo35QqmNytmZJFwfU/2fjy25R
 He0Xvy+tTcq5CQ9Fb1dNmI5PD+ylR7knKVHtwAmCF8Mtqdowc3PvhMpWFaltPKuvExxU
 nwINI/12W8W185b+/Z9VXqpbHVpHjwMKRJLFHtYZBT3TSJNzhzlEcHpMblrTHpaHen2U
 8SHP+RmnkbZLop2kE7LQO1nFN7fKlGGIAQuz1o9dZYiy1Hd6tElb/h2VASXNhbOkvKyl
 7Esw==
X-Gm-Message-State: AOJu0Yyhv5x0cr1iGuMeye9ZTcpNc5u9sig161fsxDXuvCsIPz2bO7UM
 /x+tCW/F5twvoIdIJIC1vp2XqReZmIC10UgJ2S7pb+BA/6MVqS2NcTGUvv6tSb8+s4AXSxVBp/f
 5z28c+Bb+pFtSZ0hGBTq3Mis+0khhsJN60eXXgWTH3WNHVnZYDcBJPG+m+ftJPIyxVcE/FXx5Dv
 dU+WBZwQLAFGyTBZtp1raXN08VM7Fhipqb6u3mhgiAUw==
X-Gm-Gg: ASbGncvw4IzefVqIR5EMCMwuJij7i9E/mDT60NM1z/g/PcOrJsV41xpsjNTHgHVY3me
 SAAb+zVEN5U3MTVYngUf+wCSrPjG+KI1J8v9DFrVO32hxSYM0OFxDFNDP8clDMzXEsUkAxwBdPO
 AWxwU0UMOkxCHEw7evLXQppmsVJEWa7CAFyOw=
X-Received: by 2002:a17:90b:3ec5:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-313f1e51737mr19127700a91.33.1750109541350; 
 Mon, 16 Jun 2025 14:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnsjJxSV3qwmEqzq6CDLSvFWGRIBi2vuQbZopaUfeAqL8OfAIEzOAfHdMwgtW/zcdD96Bcb8b9ThUu0QgShiw=
X-Received: by 2002:a17:90b:3ec5:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-313f1e51737mr19127667a91.33.1750109540949; Mon, 16 Jun 2025
 14:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250616211604.1399219-1-jsnow@redhat.com>
In-Reply-To: <20250616211604.1399219-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 16 Jun 2025 17:32:08 -0400
X-Gm-Features: AX0GCFta3gawThzRKNaWLB1a4xsJa2t_j9VkW1_WaV3X4Tq6MxOFq-_334B6yv8
Message-ID: <CAFn=p-YxYriosFwOu5Nk0cYnCb0ffazai_JSa2KDSAANiGPw=Q@mail.gmail.com>
Subject: Re: [PATCH] docs/contrib: add insert_crossrefs script
To: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com
Content-Type: multipart/alternative; boundary="00000000000081cf5f0637b72122"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

--00000000000081cf5f0637b72122
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Markus, Eric: Some commentary and additional information below.

I did not polish this script as I believe it's hacky enough that covering
all of the edge cases, testing and documentation is more effort than it's
worth, but I still signed off on it in case someone wanted to "adopt it".
My intent here is really just to advertise "Here's how I wrote that series"
and give you opportunities to spot problems with the programmatic
conversion before I send out my v2 so I can keep the email bombs to a
minimum.

My as-of-now-unsent v2 includes any additional instances located by this
version of the script, as well as one or two manual instances of the
ignored tokens that looked appropriate to convert.

Eric: Thank you for diving into the series, I appreciate it.

On Mon, Jun 16, 2025 at 5:16=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> This isn't really meant for inclusion as it's a bit of a hackjob, but I
> figured it would be best to share it in some form or another to serve as
> a basis for a kind of meta-review of the crossreferenceification series.
>
> This script is designed to convert 'name', "name", name, and @name
> instances in qapi/*.json files to `name` for the purposes of
> cross-referencing commands, events, and data types in the generated HTML
> documentation. It is specifically tuned for our QAPI files and is not
> suitable for running on generic rST source files. It can likely be made
> to operate on QEMU guest agent or other qapi JSON files with some edits
> to which files its opening.
>
> Navigate to your qemu/qapi/ directory and run this script with "python
> insert_crossrefs.py" and it'll handle the rest. Definitely don't run it
> in a non-git-controlled folder, it edits your source files.
>

Specifically, "python3 ../contrib/autoxref/insert_crossrefs.py"


>
> (Yes, in polishing this script, I found a few instances of
> cross-references I missed in my v1 series. I figure I'll let us discuss
> the conversion a bit before I send out a v2 patchbomb.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
>
---
>  contrib/autoxref/insert_crossrefs.py | 69 ++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 contrib/autoxref/insert_crossrefs.py
>
> diff --git a/contrib/autoxref/insert_crossrefs.py
> b/contrib/autoxref/insert_crossrefs.py
> new file mode 100644
> index 00000000000..399dd7524c2
> --- /dev/null
> +++ b/contrib/autoxref/insert_crossrefs.py
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import re
> +import sys
> +
> +if not os.path.exists("qapi-schema.json"):
> +    raise Exception(
> +        "This script was meant to be run from the qemu.git/qapi
> directory."
> +    )
> +sys.path.append("../scripts/")
> +
> +from qapi.schema import QAPISchema, QAPISchemaDefinition
> +
> +# Adjust this global to exclude certain tokens from being xreffed.
> +SKIP_TOKENS =3D ('String', 'stop', 'transaction', 'eject', 'migrate',
> 'quit')
>

At least *some* of these are still valid conversions, but the majority are
not. You can always comment out this line and review the diff in your
working tree to see what I mean.


> +
> +print("Compiling schema to build list of reference-able entities ...",
> end=3D'')
> +tokens =3D []
> +schema =3D QAPISchema("qapi-schema.json")
> +for ent in schema._entity_list:
> +    if isinstance(ent, QAPISchemaDefinition) and not ent.is_implicit():
> +        if ent.name not in SKIP_TOKENS:
> +            tokens.append(ent.name)
> +print("OK")
> +
> +patt_names =3D r'(' + '|'.join(tokens) + r')'
> +
> +# catch 'token' and "token" specifically
> +patt =3D re.compile(r'([\'"]|``)' + patt_names + r'\1')
> +# catch naked instances of token, excluding those where prefixed or
> +# suffixed by a quote, dash, or word character. Exclude "@" references
> +# specifically to handle them elsewhere. Exclude <name> matches, as
> +# these are explicit cross-reference targets.
> +patt2 =3D r"(?<![-@`'\"\w<])" + patt_names + r"(?![-`'\"\w>])"
>

I'm quite aware this pattern doesn't match <token> specifically, because
the suffixes and prefixes are not contextually linked. Hacky. Got the job
done. Probably doesn't miss anything...


> +# catch @references. prohibit when followed by ":" to exclude members
> +# whose names happen to match xreffable entities.
> +patt3 =3D r"@" + patt_names + r"(?![-\w:])"
>

Excluding "@foo:" is also kludgy, but in manual review it didn't miss
anything.

I'm sure there's some big-brained way to not need three separate patterns,
but I refuse to learn regex any better than I already have so I have some
brain space left to admire flowers and birds.


> +
> +
> +
> +
> +for file in os.scandir():
> +    outlines =3D []
> +    if not file.name.endswith(".json"):
> +        continue
> +    print(f"Scanning {file.name} ...")
> +    with open(file.name) as searchfile:
> +        block_start =3D False
> +        for line in searchfile:
> +            # Don't mess with the start of doc blocks.
> +            # We don't want to convert "# @name:" to a reference!
> +            if block_start and line.startswith('# @'):
> +                outlines.append(line)
> +                continue
> +            block_start =3D bool(line.startswith('##'))
>

Similarly, I'm sure I could bake these ad-hoc conditions into the regexes
themselves, but it's harder and makes the expressions uglier. For a script
that only needs to be run once, whatever.


> +
> +            # Don't mess with anything outside of comment blocks,
> +            # and don't mess with example blocks. We use five spaces
> +            # as a heuristic for detecting example blocks. It's not
> perfect,
> +            # but it seemingly does the job well.
> +            if line.startswith('# ') and not line.startswith('#     '):
> +                line =3D re.sub(patt, r'`\2`', line)
> +                line =3D re.sub(patt2, r'`\1`', line)
> +                line =3D re.sub(patt3, r'`\1`', line)
> +            outlines.append(line)
> +    with open(file.name, "w") as outfile:
> +        for line in outlines:
> +            outfile.write(line)
> --
> 2.48.1


Thanks!

--00000000000081cf5f0637b72122
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div></div><div>Markus, Eric: Some commentary and addition=
al information below.</div><div><br></div><div>I did not polish this script=
 as I believe it&#39;s hacky enough that=20
covering all of the edge cases, testing and documentation is more effort
 than it&#39;s worth, but I still signed off on it in case someone wanted t=
o
&quot;adopt it&quot;. My intent here is really just to advertise &quot;Here=
&#39;s how I=20
wrote that series&quot; and give you opportunities to spot problems with th=
e=20
programmatic conversion before I send out my v2 so I can keep the email=20
bombs to a minimum.</div><div><br></div><div>My as-of-now-unsent v2 include=
s any additional instances located by this version of the script, as well a=
s one or two manual instances of the ignored tokens that looked appropriate=
 to convert.</div><div><br></div><div>Eric: Thank you for diving into the s=
eries, I appreciate it.</div><div><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 16, 202=
5 at 5:16=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsno=
w@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">This isn&#39;t really meant for inclusion as it&#39;s a bit of =
a hackjob, but I<br>
figured it would be best to share it in some form or another to serve as<br=
>
a basis for a kind of meta-review of the crossreferenceification series.<br=
>
<br>
This script is designed to convert &#39;name&#39;, &quot;name&quot;, name, =
and @name<br>
instances in qapi/*.json files to `name` for the purposes of<br>
cross-referencing commands, events, and data types in the generated HTML<br=
>
documentation. It is specifically tuned for our QAPI files and is not<br>
suitable for running on generic rST source files. It can likely be made<br>
to operate on QEMU guest agent or other qapi JSON files with some edits<br>
to which files its opening.<br>
<br>
Navigate to your qemu/qapi/ directory and run this script with &quot;python=
<br>
insert_crossrefs.py&quot; and it&#39;ll handle the rest. Definitely don&#39=
;t run it<br>
in a non-git-controlled folder, it edits your source files.<br></blockquote=
><div><br></div><div>Specifically, &quot;python3 ../contrib/autoxref/insert=
_crossrefs.py&quot;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
(Yes, in polishing this script, I found a few instances of<br>
cross-references I missed in my v1 series. I figure I&#39;ll let us discuss=
<br>
the conversion a bit before I send out a v2 patchbomb.)<br>
<br>
Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"=
_blank">jsnow@redhat.com</a>&gt;<br></blockquote><div></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0contrib/autoxref/insert_crossrefs.py | 69 +++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 69 insertions(+)<br>
=C2=A0create mode 100644 contrib/autoxref/insert_crossrefs.py<br>
<br>
diff --git a/contrib/autoxref/insert_crossrefs.py b/contrib/autoxref/insert=
_crossrefs.py<br>
new file mode 100644<br>
index 00000000000..399dd7524c2<br>
--- /dev/null<br>
+++ b/contrib/autoxref/insert_crossrefs.py<br>
@@ -0,0 +1,69 @@<br>
+# SPDX-License-Identifier: GPL-2.0-or-later<br>
+<br>
+import os<br>
+import re<br>
+import sys<br>
+<br>
+if not os.path.exists(&quot;qapi-schema.json&quot;):<br>
+=C2=A0 =C2=A0 raise Exception(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;This script was meant to be run from the=
 qemu.git/qapi directory.&quot;<br>
+=C2=A0 =C2=A0 )<br>
+sys.path.append(&quot;../scripts/&quot;)<br>
+<br>
+from qapi.schema import QAPISchema, QAPISchemaDefinition<br>
+<br>
+# Adjust this global to exclude certain tokens from being xreffed.<br>
+SKIP_TOKENS =3D (&#39;String&#39;, &#39;stop&#39;, &#39;transaction&#39;, =
&#39;eject&#39;, &#39;migrate&#39;, &#39;quit&#39;)<br></blockquote><div><b=
r></div><div>At least *some* of these are still valid conversions, but the =
majority are not. You can always comment out this line and review the diff =
in your working tree to see what I mean.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
+<br>
+print(&quot;Compiling schema to build list of reference-able entities ...&=
quot;, end=3D&#39;&#39;)<br>
+tokens =3D []<br>
+schema =3D QAPISchema(&quot;qapi-schema.json&quot;)<br>
+for ent in schema._entity_list:<br>
+=C2=A0 =C2=A0 if isinstance(ent, QAPISchemaDefinition) and not ent.is_impl=
icit():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://ent.name" rel=3D"noreferr=
er" target=3D"_blank">ent.name</a> not in SKIP_TOKENS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tokens.append(<a href=3D"http://=
ent.name" rel=3D"noreferrer" target=3D"_blank">ent.name</a>)<br>
+print(&quot;OK&quot;)<br>
+<br>
+patt_names =3D r&#39;(&#39; + &#39;|&#39;.join(tokens) + r&#39;)&#39;<br>
+<br>
+# catch &#39;token&#39; and &quot;token&quot; specifically<br>
+patt =3D re.compile(r&#39;([\&#39;&quot;]|``)&#39; + patt_names + r&#39;\1=
&#39;)<br>
+# catch naked instances of token, excluding those where prefixed or<br>
+# suffixed by a quote, dash, or word character. Exclude &quot;@&quot; refe=
rences<br>
+# specifically to handle them elsewhere. Exclude &lt;name&gt; matches, as<=
br>
+# these are explicit cross-reference targets.<br>
+patt2 =3D r&quot;(?&lt;![-@`&#39;\&quot;\w&lt;])&quot; + patt_names + r&qu=
ot;(?![-`&#39;\&quot;\w&gt;])&quot;<br></blockquote><div><br></div><div>I&#=
39;m quite aware this pattern doesn&#39;t match &lt;token&gt; specifically,=
 because the suffixes and prefixes are not contextually linked. Hacky. Got =
the job done. Probably doesn&#39;t miss anything...</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+# catch @references. prohibit when followed by &quot;:&quot; to exclude me=
mbers<br>
+# whose names happen to match xreffable entities.<br>
+patt3 =3D r&quot;@&quot; + patt_names + r&quot;(?![-\w:])&quot;<br></block=
quote><div><br></div><div>Excluding &quot;@foo:&quot; is also kludgy, but i=
n manual review it didn&#39;t miss anything.</div><div><br></div><div>I&#39=
;m sure there&#39;s some big-brained way to not need three separate pattern=
s, but I refuse to learn regex any better than I already have so I have som=
e brain space left to admire flowers and birds.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+<br>
+<br>
+<br>
+for file in os.scandir():<br>
+=C2=A0 =C2=A0 outlines =3D []<br>
+=C2=A0 =C2=A0 if not file.name.endswith(&quot;.json&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 print(f&quot;Scanning {<a href=3D"http://file.name" rel=3D"n=
oreferrer" target=3D"_blank">file.name</a>} ...&quot;)<br>
+=C2=A0 =C2=A0 with open(<a href=3D"http://file.name" rel=3D"noreferrer" ta=
rget=3D"_blank">file.name</a>) as searchfile:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 block_start =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in searchfile:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Don&#39;t mess with the start =
of doc blocks.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We don&#39;t want to convert &=
quot;# @name:&quot; to a reference!<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if block_start and line.startswi=
th(&#39;# @&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outlines.append(li=
ne)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block_start =3D bool(line.starts=
with(&#39;##&#39;))<br></blockquote><div><br></div><div>Similarly, I&#39;m =
sure I could bake these ad-hoc conditions into the regexes themselves, but =
it&#39;s harder and makes the expressions uglier. For a script that only ne=
eds to be run once, whatever.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Don&#39;t mess with anything o=
utside of comment blocks,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # and don&#39;t mess with exampl=
e blocks. We use five spaces<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # as a heuristic for detecting e=
xample blocks. It&#39;s not perfect,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # but it seemingly does the job =
well.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if line.startswith(&#39;# &#39;)=
 and not line.startswith(&#39;#=C2=A0 =C2=A0 =C2=A0&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D re.sub(pa=
tt, r&#39;`\2`&#39;, line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D re.sub(pa=
tt2, r&#39;`\1`&#39;, line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D re.sub(pa=
tt3, r&#39;`\1`&#39;, line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outlines.append(line)<br>
+=C2=A0 =C2=A0 with open(<a href=3D"http://file.name" rel=3D"noreferrer" ta=
rget=3D"_blank">file.name</a>, &quot;w&quot;) as outfile:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in outlines:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outfile.write(line)<br>
-- <br>
2.48.1</blockquote><div><br></div><div>Thanks! <br></div></div></div>

--00000000000081cf5f0637b72122--


