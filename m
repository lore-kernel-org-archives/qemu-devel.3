Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18D6C61DCB
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 08:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0EHP-0006lL-TP; Sat, 29 Aug 2026 04:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x0EHI-0006km-3Z
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 04:19:05 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x0EHG-0001Ez-Ap
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 04:19:03 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3968e063f84so1364660a91.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 01:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787991540; cv=none;
 d=google.com; s=arc-20260327;
 b=djnHnSpRj97lIP8bd6XfQ8lCfISQQwigw3Ni9Q6L1/qEfcccA6CzAtrikqnZmjA3fI
 Cwsz65tTM1p7racwzrKSbXH+ob4DAj00S5IXMQGmVgxbn5lW8Klz3t/2Npfayc6DVqJV
 uI0nDMqBNpzlWmtaKRPNDIBTARSJdjRIsURirLKHnXX1fej49cgvXYrQHBxu963/LFjj
 B8FXLNwGoQ5mom4DvGjoICHta5wwcXCdD16sYKHv/Ql2IKOYiUnmfFK57VzNGrTm3PIO
 T+E7DoVLFxfr1chtjLga8V0fRbkm2AF0xtZIoUvvIrCdahmbDUZf5XiD4ZVk5gQl2ZOu
 hLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hYbSiA2QzHZytZanDSKgoJaiW7XisTcNeVsl/eIs60Q=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=Tpy6eN7UM1l1tiv0i1uXg7nE4ZrCLGFlKZtWM5an62f6VYERivmzQSTvzYdlntmLDF
 CB1eQabxaPXJ2vFULBVHhDipFkvaoJm/D5y+zbV6so4IurLt/gO9xEnU5XsoOf518a/e
 Js4thf3dumfsIUWFpIfpGYtuaY68ImnoSyRkeOtu3YSMTH3qei4QsD+DFI59u5ZclGhb
 Rjo5J6U9oZxmLR+WG830K4Q4mC/v7I+T+2ig93nezcsTc6s0p9i9KKcPnuOuoxmrTx3y
 ODxUXnFSVjm8eLlxLfrqTtp23XcRsgcaxf/jjX6GXQWm3EV8wIquSDjYE7OxtojqwOCS
 h0Ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787991540; x=1788596340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hYbSiA2QzHZytZanDSKgoJaiW7XisTcNeVsl/eIs60Q=;
 b=kOlQzUSLF/BFjqAQEutPKqmGDb3rGY5T5uCorEqdTsEUsZWo/5UzRWXoShVIANzw3q
 pGA5ftnu8lKQfT7/llUiRqPZHmfY1HeERruafoiQol88re4R4hCYR6K54kUIWglMZTec
 oaiRTj5FlCsQNuEp+Pn2UBz3c77/1WoJIk/VduzxsBxR2XUI9E8blik5ADLuvFfkwHv/
 46KjYY02JRISXfdXBPVLn5X30ZrutRr5bV/rO6n9l36i7BbZrEVtiT2XEj2BbPLW9l5/
 LnD2DNmPv2gMy6/+AtSpIaiJwmiIDFu3sNdubl12ia49JligtVM80KV4P32zpAyK9pbZ
 mZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787991540; x=1788596340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hYbSiA2QzHZytZanDSKgoJaiW7XisTcNeVsl/eIs60Q=;
 b=YKigB8fJ52aTg7newdKZfBtaJ/C8s8UVSftSc4p9yNOz7eDEHn2W1EtXI0BohEVc1g
 tO39RgzECnXzaVsGeu2JhpNxEepZ4/S05KeSUzP1zN3NltOYtTYKZ2AOHHltuljiZ3NA
 uZJ+zru1tb4nd/acBqsy0ZAtFAu9UGVGGWmSG/G6FfPgz/EBktW9qxHOFJqn0WeEhoZG
 M/Swwm9coGfzEyQqZs6hOCUlKEZKnpJlx9QOAq1yVJUJP0wZAUw59pR5qAg6fSoBC9DL
 1KaKGpJEeMTwcBmg7MWm5hAw2uM8rmC2pMLqhojkmfrWQvpWUK+O6p8wMes+gChUKo4F
 LrfA==
X-Gm-Message-State: AFuF++m02C4wEemQsJWlcsKvZ7NodlHczUr6j7QXamXhNANtTt7h9pmt
 qd+FSpWXeiaUaNG6T+EaT1rD5KkeBAdrZKv6IXjDE1WeB8K6ws4jDrxYniHPFZA+LS+D8Yhed8/
 tx/rd+SYIDE7UM1lu5bPS0QmsM1Qqs+s=
X-Gm-Gg: AYBFou007w4Ib0CZc9iP9U3F30RXKvACJkFMJKJ6k8dsvyDuINERxuSUprxiTUoUEDx
 Bgz7TI9nLllNaqzHGouwrzRszy0Mqbqn89njkdPT0cdLFzPbXLqgdiSqj1ScOTvkDJoJwLnRjOq
 oYpvlyfESfsJeOKKCk3eKpLWFZLEfzwuaQkOoYmhgCe18jxXMMO4fjhjJC8a+996etCM+UKfa45
 yR+VS/3JFMLFuttAje1a6alxylJ967FInl95g9BwxWGvAydq/flw758hjvYBzHo4MrFzRDqSKyg
 ebNg8M/aJX9tEFpLrXpsuPIgme/AEYNEAQNQiWMM+d3IJ3dRIVGKqnz3wIW+hhOaxjmLBqgBIr8
 Z
X-Received: by 2002:a17:90b:1d46:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-396d0f8d841mr22088263a91.14.1787991540436; Sat, 29 Aug 2026
 01:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
 <d07e2f13-2c3c-43b5-8ad2-cbd2299f90bf@linaro.org>
In-Reply-To: <d07e2f13-2c3c-43b5-8ad2-cbd2299f90bf@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 12:18:48 +0400
X-Gm-Features: AcwNN1Wl7sBrn6xJz0AEKf-wQynNvlH9sFbs-wj1gnpHOAiZXxcpDjlV8GfNZcs
Message-ID: <CAJ+F1CJS=eHFEpjM-AnXgfRrcAKKQqNJiytQP-ArDqDieapAnQ@mail.gmail.com>
Subject: Re: [GIT PULL 00/50] Make HMP optional
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGkNCg0KT24gU2F0LCBBdWcgMjksIDIwMjYgYXQgNDo1M+KAr0FNIFJpY2hhcmQgSGVuZGVyc29u
DQo8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4gd3JvdGU6DQo+DQo+IE9uIDgvMjgvMjYg
MTM6NDEsIE1hcmMtQW5kcsOpIEx1cmVhdSB3cm90ZToNCj4gPiBUaGUgZm9sbG93aW5nIGNoYW5n
ZXMgc2luY2UgY29tbWl0IDBhMWViZDQ0OGIzOGFmYWExMTg1OTdjYmI2MzNkYmVjMjRlZjc0ZDM6
DQo+ID4NCj4gPiAgICB0Y2cvbG9vbmdhcmNoNjQ6IEZpeCBjb21waWxlIGlzc3VlIExvb25nQXJj
aCBob3N0ICgyMDI2LTA4LTI3IDExOjA0OjAxIC0wNzAwKQ0KPiA+DQo+ID4gYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQo+ID4NCj4gPiAgICBodHRwczovL2dpdGxhYi5j
b20vbWFyY2FuZHJlLmx1cmVhdS9xZW11LmdpdCB0YWdzL25vaG1wLXByLXYxDQo+ID4NCj4gPiBm
b3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gN2EzNjQ3ZDY3YTU0NzI4ZThmODhhYTBmYTdm
NWU5YTk4YmYwNmE1MToNCj4gPg0KPiA+ICAgIGdpdGxhYjogLS1kaXNhYmxlLWhtcCBpbiBidWls
ZC13aXRob3V0LWRlZmF1bHRzICgyMDI2LTA4LTI5IDAwOjQxOjMyICswNDAwKQ0KPiA+DQo+ID4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+IE1ha2UgSE1QIG9wdGlvbmFsDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
YXJjLUFuZHLDqSBMdXJlYXU8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPg0KPiBZb3Ug
bmVlZCB0byB1cGRhdGUgc29tZSB0ZXN0cy4gIFdpdGgganVzdCAiY29uZmlndXJlIC0tZGlzYWJs
ZS1obXAiOg0KPg0KPiDilrYgIDE3OC8xMDU2IC94ODZfNjQvaWRlL21pZ3JhdGlvbi9jaHNfc25h
cHNob3QgLQ0KPiBFUlJPUjouLi9wdWJsaXNoL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6OTk4OnF0
ZXN0X3ZobXA6IGFzc2VydGlvbg0KPiBmYWlsZWQ6IChyZXQpIEZBSUwNCj4g4pa2ICAxNzgvMTA1
Ng0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgRVJST1INCj4gICAxNzgvMTA1NiBxdGVzdCtx
dGVzdC14ODZfNjQrc2xvdyAtIHFlbXU6cXRlc3QteDg2XzY0L2lkZS10ZXN0DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRVJST1IgICAgICAgICAgICAxLjYxcyAgIGtpbGxlZCBieSBzaWdu
YWwgNg0KPiBTSUdBQlJUDQo+ID4+Pj4gUlVTVF9CQUNLVFJBQ0U9MSBRVEVTVF9RRU1VX0lNRz0u
L3FlbXUtaW1nIFBZVEhPTj0vaG9tZS9ydGgvcWVtdS9ibGQtcHViL3B5dmVudi9iaW4vcHl0aG9u
MyBNU0FOX09QVElPTlM9aGFsdF9vbl9lcnJvcj0xOmFib3J0X29uX2Vycm9yPTE6cHJpbnRfc3Vt
bWFyeT0xOnByaW50X3N0YWNrdHJhY2U9MSBVQlNBTl9PUFRJT05TPWhhbHRfb25fZXJyb3I9MTph
Ym9ydF9vbl9lcnJvcj0xOnByaW50X3N1bW1hcnk9MTpwcmludF9zdGFja3RyYWNlPTEgUVRFU1Rf
UUVNVV9TVE9SQUdFX0RBRU1PTl9CSU5BUlk9Li9zdG9yYWdlLWRhZW1vbi9xZW11LXN0b3JhZ2Ut
ZGFlbW9uIEdfVEVTVF9EQlVTX0RBRU1PTj0vaG9tZS9ydGgvcWVtdS9wdWJsaXNoL3Rlc3RzL2Ri
dXMtZGFlbW9uLnNoIFFURVNUX1FFTVVfQklOQVJZPS4vcWVtdS1zeXN0ZW0teDg2XzY0IFFURVNU
X1FFTVVfVk5DX0JJTkFSWT0uL3Rvb2xzL3FlbXUtdm5jL3FlbXUtdm5jIEFTQU5fT1BUSU9OUz1o
YWx0X29uX2Vycm9yPTE6YWJvcnRfb25fZXJyb3I9MTpwcmludF9zdW1tYXJ5PTEgTUFMTE9DX1BF
UlRVUkJfPTQwIE1FU09OX1RFU1RfSVRFUkFUSU9OPTEgL2hvbWUvcnRoL3FlbXUvYmxkLXB1Yi90
ZXN0cy9xdGVzdC9pZGUtdGVzdCAtLXRhcCAtaw0KPiDigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJUNCj4g
4pyADQo+IOKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKAleKA
leKAleKAleKAleKAleKAleKAleKAleKAleKAleKAlQ0KPiBzdGRlcnI6DQo+ICoqDQo+IEVSUk9S
Oi4uL3B1Ymxpc2gvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzo5OTg6cXRlc3RfdmhtcDogYXNzZXJ0
aW9uDQo+IGZhaWxlZDogKHJldCkNCj4NCj4gKHRlc3QgcHJvZ3JhbSBleGl0ZWQgd2l0aCBzdGF0
dXMgY29kZSAtNikNCg0KSXQncyBhIG5ldyB0ZXN0IHRvIHNraXAgZm9yIG5vdyAoYW5kIGNvbnZl
cnQgbGF0ZXIpLCBJJ2xsIHNlbmQgdjIgb2YNCmp1c3QgdGhlIGNvdmVyIGFmdGVyIENJIGlzIGFs
bCBncmVlbi4NCg==

