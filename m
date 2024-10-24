Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02E7CE8E65
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 11:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3w1C-0007Ii-8D; Thu, 24 Oct 2024 07:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3w17-0007IT-H4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 07:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3w0v-000849-MS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 07:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729769304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=swoW7x/oImdx9ZdK6layscRfMxAe1wDM048OBpIWw9o=;
 b=JaeR+M62HJfv9hpw/ZaXtvTV8U8+0ykhiHAjj+T52/PS16/Nha8RndF7DxxjoLHC/naR9c
 n7tJ63ZLX+3OGX8Y93rjNVaL9Q9TlEjs0SLHNkGKaOrPnZy80UeZFyaTN1IRYUDGQ6b117
 qAr+CLNMx6yFWmUSd7B7uTU05FIyN2A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-QxwoUmMONP6ZvtPI4EtVzQ-1; Thu, 24 Oct 2024 07:28:23 -0400
X-MC-Unique: QxwoUmMONP6ZvtPI4EtVzQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so506810f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 04:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769301; x=1730374101;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swoW7x/oImdx9ZdK6layscRfMxAe1wDM048OBpIWw9o=;
 b=QSq41XVCOO1m/pfke/BkSzlypoIDORHWxnpGTlCXDJtGThEl4eLWNT9x5oiAdbCeZx
 DG0qylSu0yZ/rROAqMKdmS8X73rNCYaCGrkAvvMnI/kLAAg91/X/S4TQgtZxd/hBUsP6
 HfMSbRMsBpKYkflLxuj8Wa252l1b2t0pEPVJCJljV5ADUWTEsVJIMAYXwd4xXcBlsx8L
 MbM5spGqtOZKacw8+HJD7uXoU4b5jn2x9EkSLSFLS3EL/2nOFxu38yExGktR7Ds0r70Y
 /HOrJm+yjyeKqpEskPREBMWbr51455VpYJVSJd4gmtN7rLX7ECkKSnaTwebh5fUQEeXd
 2zcw==
X-Gm-Message-State: AOJu0YyNPw36uxmWozK+yJNWRlFWI8HWa50cfk2AItLcEkZ0g7ijstx/
 WjP4qMG85mATTyuq/EM8PZvFB5qUSgVzkDDfQ+2emUVgf8R27q+RnhsD9Kj3B5dnC4abMcUC/hs
 ItwSVUmVxQ3NcGSzthUycg0vN5sBzV9bjV8QmGW1eJ1Nlvbfs4ur2v7CKgovY5vSSOiA69iLDxa
 h26GXwFfzQC76L/QivZhuSonLNfkda4EIAt2aaj6c=
X-Received: by 2002:a5d:5f8e:0:b0:37d:33ab:de30 with SMTP id
 ffacd0b85a97d-37efceff70dmr4575776f8f.8.1729769301388; 
 Thu, 24 Oct 2024 04:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXH0ryeQUaU37Kr/IGcU2rB2921a8/fsCAaN0NEIqDKBZ2bZ1QL/jIpzwsouMtqG8Kv7L2Kw==
X-Received: by 2002:a5d:5f8e:0:b0:37d:33ab:de30 with SMTP id
 ffacd0b85a97d-37efceff70dmr4575750f8f.8.1729769300926; 
 Thu, 24 Oct 2024 04:28:20 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm11063912f8f.91.2024.10.24.04.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 04:28:20 -0700 (PDT)
Message-ID: <ebe4a68a-ee9f-426c-b8d1-f60c189fc22a@redhat.com>
Date: Thu, 24 Oct 2024 13:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] rust: allow older versions of rustc and bindgen
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
References: <20241022100956.196657-1-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/22/24 12:09, Paolo Bonzini wrote:
> This is the second of three series needed to enable Rust for all CI
> jobs (the third is due to differences in the functionality between
> C and Rust implementations of PL011, for which I have sent the RFC
> a little earlier).
> 
> My overall patch queue can be found at branch rust-next of my git
> repository https://gitlab.com/bonzini/qemu.git.
> 
> Note that this requires "meson subprojects update --reset" in order to do
> an incremental build if you have already downloaded the Rust subprojects.
> While I have a solution for that (modeled after scripts/git-submodule.sh),
> I first need to check with the Meson folks whether my script is using only
> stable interfaces.

This is the contents of subprojects/packagefiles/bilge-impl-1.63.0.patch 
in base64 encoding.  You can replace it in your tree by executing the 
command:

base64 -d <<\EOF > subprojects/packagefiles/bilge-impl-1.63.0.patch

LS0tIGEvc3JjL3NoYXJlZC9kaXNjcmltaW5hbnRfYXNzaWduZXIucnMKKysrIGIvc3JjL3NoYXJl
ZC9kaXNjcmltaW5hbnRfYXNzaWduZXIucnMKQEAgLTI2LDIwICsyNiwyMCBAQAogICAgICAgICBs
ZXQgZGlzY3JpbWluYW50X2V4cHIgPSAmZGlzY3JpbWluYW50LjE7DQogICAgICAgICBsZXQgdmFy
aWFudF9uYW1lID0gJnZhcmlhbnQuaWRlbnQ7DQogDQotICAgICAgICBsZXQgRXhwcjo6TGl0KEV4
cHJMaXQgeyBsaXQ6IExpdDo6SW50KGludCksIC4uIH0pID0gZGlzY3JpbWluYW50X2V4cHIgZWxz
ZSB7DQorICAgICAgICBpZiBsZXQgRXhwcjo6TGl0KEV4cHJMaXQgeyBsaXQ6IExpdDo6SW50KGlu
dCksIC4uIH0pID0gZGlzY3JpbWluYW50X2V4cHIgew0KKyAgICAgICAgICAgIGxldCBkaXNjcmlt
aW5hbnRfdmFsdWU6IHUxMjggPSBpbnQuYmFzZTEwX3BhcnNlKCkudW53cmFwX29yX2Vsc2UodW5y
ZWFjaGFibGUpOw0KKyAgICAgICAgICAgIGlmIGRpc2NyaW1pbmFudF92YWx1ZSA+IHNlbGYubWF4
X3ZhbHVlKCkgew0KKyAgICAgICAgICAgICAgICBhYm9ydCEodmFyaWFudCwgIlZhbHVlIG9mIHZh
cmlhbnQgZXhjZWVkcyB0aGUgZ2l2ZW4gbnVtYmVyIG9mIGJpdHMiKQ0KKyAgICAgICAgICAgIH0N
CisNCisgICAgICAgICAgICBTb21lKGRpc2NyaW1pbmFudF92YWx1ZSkNCisgICAgICAgIH0gZWxz
ZSB7DQogICAgICAgICAgICAgYWJvcnQhKA0KICAgICAgICAgICAgICAgICBkaXNjcmltaW5hbnRf
ZXhwciwNCiAgICAgICAgICAgICAgICAgInZhcmlhbnQgYHt9YCBpcyBub3QgYSBudW1iZXIiLCB2
YXJpYW50X25hbWU7DQogICAgICAgICAgICAgICAgIGhlbHAgPSAib25seSBsaXRlcmFsIGludGVn
ZXJzIGN1cnJlbnRseSBzdXBwb3J0ZWQiDQogICAgICAgICAgICAgKQ0KLSAgICAgICAgfTsNCi0N
Ci0gICAgICAgIGxldCBkaXNjcmltaW5hbnRfdmFsdWU6IHUxMjggPSBpbnQuYmFzZTEwX3BhcnNl
KCkudW53cmFwX29yX2Vsc2UodW5yZWFjaGFibGUpOw0KLSAgICAgICAgaWYgZGlzY3JpbWluYW50
X3ZhbHVlID4gc2VsZi5tYXhfdmFsdWUoKSB7DQotICAgICAgICAgICAgYWJvcnQhKHZhcmlhbnQs
ICJWYWx1ZSBvZiB2YXJpYW50IGV4Y2VlZHMgdGhlIGdpdmVuIG51bWJlciBvZiBiaXRzIikNCiAg
ICAgICAgIH0NCi0NCi0gICAgICAgIFNvbWUoZGlzY3JpbWluYW50X3ZhbHVlKQ0KICAgICB9DQog
DQogICAgIGZuIGFzc2lnbigmbXV0IHNlbGYsIHZhcmlhbnQ6ICZWYXJpYW50KSAtPiB1MTI4IHsN
Ci0tLSBhL3NyYy9zaGFyZWQvZmFsbGJhY2sucnMKKysrIGIvc3JjL3NoYXJlZC9mYWxsYmFjay5y
cwpAQCAtMjIsOCArMjIsOSBAQAogICAgICAgICAgICAgfQ0KICAgICAgICAgICAgIFVubmFtZWQo
ZmllbGRzKSA9PiB7DQogICAgICAgICAgICAgICAgIGxldCB2YXJpYW50X2ZpZWxkcyA9IGZpZWxk
cy51bm5hbWVkLml0ZXIoKTsNCi0gICAgICAgICAgICAgICAgbGV0IE9rKGZhbGxiYWNrX3ZhbHVl
KSA9IHZhcmlhbnRfZmllbGRzLmV4YWN0bHlfb25lKCkgZWxzZSB7DQotICAgICAgICAgICAgICAg
ICAgICBhYm9ydCEodmFyaWFudCwgImZhbGxiYWNrIHZhcmlhbnQgbXVzdCBoYXZlIGV4YWN0bHkg
b25lIGZpZWxkIjsgaGVscCA9ICJ1c2Ugb25seSBvbmUgZmllbGQgb3IgY2hhbmdlIHRvIGEgdW5p
dCB2YXJpYW50IikNCisgICAgICAgICAgICAgICAgbGV0IGZhbGxiYWNrX3ZhbHVlID0gbWF0Y2gg
dmFyaWFudF9maWVsZHMuZXhhY3RseV9vbmUoKSB7DQorICAgICAgICAgICAgICAgICAgICBPayhv
aykgPT4gb2ssDQorICAgICAgICAgICAgICAgICAgICBfID0+IGFib3J0ISh2YXJpYW50LCAiZmFs
bGJhY2sgdmFyaWFudCBtdXN0IGhhdmUgZXhhY3RseSBvbmUgZmllbGQiOyBoZWxwID0gInVzZSBv
bmx5IG9uZSBmaWVsZCBvciBjaGFuZ2UgdG8gYSB1bml0IHZhcmlhbnQiKQ0KICAgICAgICAgICAg
ICAgICB9Ow0KIA0KICAgICAgICAgICAgICAgICBpZiAhaXNfbGFzdF92YXJpYW50IHsNCg==

Paolo


