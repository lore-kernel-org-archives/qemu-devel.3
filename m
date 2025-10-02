Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8007CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 22:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4RN1-0006vQ-2P; Thu, 02 Oct 2025 18:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4RMy-0006uo-9F
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 18:01:48 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4RMo-0004Xt-C8
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 18:01:46 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so1890788a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759442489; x=1760047289; darn=nongnu.org;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+tC5ZBsGLjaO+hy+yiAyxAKCk4029nhONroAV4EWu+E=;
 b=JIxo6NqMhQAJH5XaRNtf+vZ8wTQ357hy1O7A453em832B8iJVEUIcN5uiUfDdZYQ+n
 AujAYICkxoT2v2Nm89uM5rn7b1FSm2JypdMsdUfG5K25fqZaCfMK/5CABBl1NF/jAyij
 RgQ+bee03X1og8+/1g+HIKjsGK5VmoMfSF9WHDdrxUyDM0lr+0vIoYye+LHGDEdsfuHf
 GeB7s3b+OV+uuM0e6q2GjazzBg+pECt+gv5jEJVUtJTP7pcpDHrHszSQ2AXoydAMf0GD
 YTjz0jZQZdSgnYggGMS+FTKl7kdaXJQMi+QInXuiFWUWXd5vaFmUn+4Nk1REDYxHQ3ZS
 Xz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759442489; x=1760047289;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+tC5ZBsGLjaO+hy+yiAyxAKCk4029nhONroAV4EWu+E=;
 b=pU/RaxBRHXQYF52qaFnHDFcUg3LGk9GhhAS9MCi6cMwQPzTJFAJF62QCGmYJ82OEdV
 a5ie8WffdE7nO0516DEc0f+U1qPXHLFSAl55rNUn3mVPnd727uH3eYwC6ihuj5u49gPC
 g3QjW5+UbrCT5oWTdkSBw30fs/6yeWR5MtP72bacGVD1aO/U9JGoqXzR5ArOj9WwXNR/
 moqoUty0nt+KTqjra0UQU3NTt3mKJODav7C+HOSx2S87/zIiSfnxWX3Sd6jGuCuUv/Bq
 VlxhP1JwhaJO+UoGYjMdMfMRcdSucTejZPt8XGtIdM9pk9o3G3k4saiE5paYYcyqHDWi
 s6KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMDOUc1sAUcQ4ap1E2+cm6+5NOzKInQ0PmgbbE7h2l/SAW7JmuiJdxXdxJB7tu80KwWKNxzqd7ctnQ@nongnu.org
X-Gm-Message-State: AOJu0Yy1P+ieGxmmmyxQIcNASvxVSf5hr2M/UnTknmi7p1zyXasAc1/0
 o291BuNOXH+4dcdMrIGn49E8xH/FZrmsxGCAo+mnjhlIh79wiLWU0LPjkEud/OiXMLM=
X-Gm-Gg: ASbGncu2HJ+L4FKHN1zZ/i0cnjlrJqO6zo9JWQLqGHRzFXk+pnjFnrSEOqF/3nVI3I7
 wIsGNzNvCAz/FbJxVfSrRzsLBbcS07gCRiQF/a1zz9fN9omQv+E8xMI3+KakoOmAcD1ZjeK1wdX
 +hRNPhzHZQaPqALetsGoRTLBZsqrxo+qwDKKfZ/5u/8PLuP2QZTNLsQriGcy5dQbqXa+mGN4QXb
 Ivm3nhtycgk1fAOWtm8e4pJ9jL9cSIL01Fksc6tIh5q7JgGaGSq55VXJ1zBFVvH/tdvowViN4Fq
 +hG1bHS5+zqren+1psptUTkjbwDNAoUB3HoQb5EV/DMopshLpsJ23q54EPUprTkf/enDGbaGL3Q
 vVT47nOWzoUjJPfR7LC8lHJ+GSYxHhQNYv3M9zdZn5dvmxxIv+D/qkeQW1cB9PZs6PL0Mi2/lXg
 ==
X-Google-Smtp-Source: AGHT+IFY06GuRFF3OOsp/kJURW7T1Jej5C4bRyNRtM4J3YODV8g8FL1uly27PJrakmcW6FN6Gg64Tg==
X-Received: by 2002:a17:90b:3ec3:b0:330:6f13:53fc with SMTP id
 98e67ed59e1d1-339c279e68bmr881448a91.27.1759442487695; 
 Thu, 02 Oct 2025 15:01:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3399cd8013dsm4158741a91.4.2025.10.02.15.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 15:01:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------EhDkpkNyU8ZiUnFFo06yC5JY"
Message-ID: <926591c0-a5bc-462b-acba-49c8842b8f0a@linaro.org>
Date: Thu, 2 Oct 2025 15:01:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] FEAT_GCS firmware update for test_rme_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251002185910.584990-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251002185910.584990-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

This is a multi-part message in MIME format.
--------------EhDkpkNyU8ZiUnFFo06yC5JY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/25 11:59 AM, Richard Henderson wrote:
> Hi Pierrick,
> 
> Here's what I need to run our RME test with FEAT_GCS enabled,
> based on your
> 
>    https://github.com/pbo-linaro/qemu-linux-stack rme_release
> 
> If your can run what's needed to update the functional artifacts,
> I can re-spin my FEAT_GCS series with that included.
> 
> Thanks,
>

Thanks for the patches Richard.

You can update concerned QEMU tests with attached patch using new artifacts.
Let me know if everything works on your side.

Regards,
Pierrick


--------------EhDkpkNyU8ZiUnFFo06yC5JY
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tests-functional-update-tests-using-TF-A-TF-RMM-to-s.patch"
Content-Disposition: attachment;
 filename*0="0001-tests-functional-update-tests-using-TF-A-TF-RMM-to-s.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiN2NjZWI3ODE1YmU1YmIzZmY2MzYzMjk0ZjJiYzg3YzI2ODFkNzE4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+CkRhdGU6IFRodSwgMiBPY3QgMjAyNSAxNDo1OToxOSAtMDcwMApT
dWJqZWN0OiBbUEFUQ0hdIHRlc3RzL2Z1bmN0aW9uYWw6IHVwZGF0ZSB0ZXN0cyB1c2luZyBU
Ri1BL1RGLVJNTSB0byBzdXBwb3J0CiBGRUFUX0dDUwoKU2lnbmVkLW9mZi1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPgotLS0KIHRlc3RzL2Z1
bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2RldmljZV9wYXNzdGhyb3VnaC5weSB8IDQgKystLQog
dGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3Rfcm1lX3Nic2FyZWYucHkgICAgICAgIHwg
NCArKy0tCiB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9ybWVfdmlydC5weSAgICAg
ICAgICAgfCA0ICsrLS0KIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0
X2RldmljZV9wYXNzdGhyb3VnaC5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0
X2RldmljZV9wYXNzdGhyb3VnaC5weQppbmRleCAxNzQzNzc4NGJiZS4uMDVhM2Y1MmQ1ZTIg
MTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2RldmljZV9wYXNz
dGhyb3VnaC5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9kZXZpY2Vf
cGFzc3Rocm91Z2gucHkKQEAgLTg1LDggKzg1LDggQEAgY2xhc3MgQWFyY2g2NERldmljZVBh
c3N0aHJvdWdoKFFlbXVTeXN0ZW1UZXN0KToKICAgICAjIGh0dHBzOi8vZG9jcy5rZXJuZWwu
b3JnL2RyaXZlci1hcGkvdmZpby5odG1sI3ZmaW8tZGV2aWNlLWNkZQogICAgIEFTU0VUX0RF
VklDRV9QQVNTVEhST1VHSF9TVEFDSyA9IEFzc2V0KAogICAgICAgICAoJ2h0dHBzOi8vZ2l0
aHViLmNvbS9wYm8tbGluYXJvL3FlbXUtbGludXgtc3RhY2svJwotICAgICAgICAgJ3JlbGVh
c2VzL2Rvd25sb2FkL2J1aWxkL2RldmljZV9wYXNzdGhyb3VnaC1jM2ZiODRhLnRhci54eicp
LAotICAgICAgICAgJzE1YWMyYjAyYmVkMGMwZWE4ZTNlMDA3ZGUwYmNmZGFmNmZkNTFjMWJh
OTgyMTNmODQxZGM3ZDAxZDZmNzJmMDQnKQorICAgICAgICAgJ3JlbGVhc2VzL2Rvd25sb2Fk
L2J1aWxkL2RldmljZV9wYXNzdGhyb3VnaC1hOTYxMmEyLnRhci54eicpLAorICAgICAgICAg
J2Y3ZDJmNzA5MTJlNzIzMTk4NmU2ZTI5M2UxYTJjNDc4NmRkMDJiZWMxMTNhN2FjYjZiZmM2
MTllOTYxNTU0NTUnKQogCiAgICAgIyBUaGlzIHRlc3RzIHRoZSBkZXZpY2UgcGFzc3Rocm91
Z2ggaW1wbGVtZW50YXRpb24sIGJ5IGJvb3RpbmcgYSBWTQogICAgICMgc3VwcG9ydGluZyBp
dCB3aXRoIHR3byBudm1lIGRpc2tzIGF0dGFjaGVkLCBhbmQgbGF1bmNoaW5nIGEgbmVzdGVk
IFZNCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9ybWVfc2Jz
YXJlZi5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X3JtZV9zYnNhcmVmLnB5
CmluZGV4IGNhODkyZTBhOGM5Li42ZjkyODU4Mzk3YSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVu
Y3Rpb25hbC9hYXJjaDY0L3Rlc3Rfcm1lX3Nic2FyZWYucHkKKysrIGIvdGVzdHMvZnVuY3Rp
b25hbC9hYXJjaDY0L3Rlc3Rfcm1lX3Nic2FyZWYucHkKQEAgLTI1LDggKzI1LDggQEAgY2xh
c3MgQWFyY2g2NFJNRVNic2FSZWZNYWNoaW5lKFFlbXVTeXN0ZW1UZXN0KToKICAgICAjIC4v
YnVpbGQuc2ggJiYgLi9hcmNoaXZlX2FydGlmYWN0cy5zaCBvdXQudGFyLnh6CiAgICAgQVNT
RVRfUk1FX1NUQUNLX1NCU0EgPSBBc3NldCgKICAgICAgICAgKCdodHRwczovL2dpdGh1Yi5j
b20vcGJvLWxpbmFyby9xZW11LWxpbnV4LXN0YWNrLycKLSAgICAgICAgICdyZWxlYXNlcy9k
b3dubG9hZC9idWlsZC9ybWVfc2JzYV9yZWxlYXNlLWE3ZjAyY2YudGFyLnh6JyksCi0gICAg
ICAgICAnMjdkODQwMGIxMWJlZmI4MjhkNmRiMGNhYjk3ZTdhZTEwMmQwOTkyYzkyOGQzZGZi
ZjM4YjI0YjZjZjZjMzI0YycpCisgICAgICAgICAncmVsZWFzZXMvZG93bmxvYWQvYnVpbGQv
cm1lX3Nic2FfcmVsZWFzZS02YTJkZmM1LnRhci54eicpLAorICAgICAgICAgJzVhZGJhNDgy
YWEwNjk5MTIyOTJhOGRhNzQ2YzZiMjEyNjgyMjRkOWQ4MWM5N2ZlN2MwYmVkNjkwNTc5ZWJk
Y2InKQogCiAgICAgIyBUaGlzIHRlc3RzIHRoZSBGRUFUX1JNRSBjcHUgaW1wbGVtZW50YXRp
b24sIGJ5IGJvb3RpbmcgYSBWTSBzdXBwb3J0aW5nIGl0LAogICAgICMgYW5kIGxhdW5jaGlu
ZyBhIG5lc3RlZCBWTSB1c2luZyBpdC4KZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwv
YWFyY2g2NC90ZXN0X3JtZV92aXJ0LnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rl
c3Rfcm1lX3ZpcnQucHkKaW5kZXggYmI2MDNhYWEyNmMuLjVlMjM3NzNmOTNkIDEwMDc1NQot
LS0gYS90ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9ybWVfdmlydC5weQorKysgYi90
ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9ybWVfdmlydC5weQpAQCAtMjMsOCArMjMs
OCBAQCBjbGFzcyBBYXJjaDY0Uk1FVmlydE1hY2hpbmUoUWVtdVN5c3RlbVRlc3QpOgogICAg
ICMgLi9idWlsZC5zaCAmJiAuL2FyY2hpdmVfYXJ0aWZhY3RzLnNoIG91dC50YXIueHoKICAg
ICBBU1NFVF9STUVfU1RBQ0tfVklSVCA9IEFzc2V0KAogICAgICAgICAoJ2h0dHBzOi8vZ2l0
aHViLmNvbS9wYm8tbGluYXJvL3FlbXUtbGludXgtc3RhY2svJwotICAgICAgICAgJ3JlbGVh
c2VzL2Rvd25sb2FkL2J1aWxkL3JtZV9yZWxlYXNlLTg2MTAxZTUudGFyLnh6JyksCi0gICAg
ICAgICAnZTQyZmVmODQzOWJhZGI1MmEwNzFhYzQ0NmZjMzNjZmY0Y2I3ZDYxMzE0YzdhMjhm
ZGJlNjFhMTFlMWZhYWQzYScpCisgICAgICAgICAncmVsZWFzZXMvZG93bmxvYWQvYnVpbGQv
cm1lX3JlbGVhc2UtNTZiYzk5ZS50YXIueHonKSwKKyAgICAgICAgICcwZTNkYzZiOGE0Yjgy
OGRiYWUwOWM5NTFhNDBkY2I3MTBlZGVkMDg0YjMyNDMyYjUwYzY5Y2Y0MTczZmZhNGJlJykK
IAogICAgICMgVGhpcyB0ZXN0cyB0aGUgRkVBVF9STUUgY3B1IGltcGxlbWVudGF0aW9uLCBi
eSBib290aW5nIGEgVk0gc3VwcG9ydGluZyBpdCwKICAgICAjIGFuZCBsYXVuY2hpbmcgYSBu
ZXN0ZWQgVk0gdXNpbmcgaXQuCi0tIAoyLjQ3LjMKCg==

--------------EhDkpkNyU8ZiUnFFo06yC5JY--

