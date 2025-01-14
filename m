Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79929C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXlaS-0003Ef-0T; Tue, 14 Jan 2025 13:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlaE-0002zX-JV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:24:12 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlaB-0004Qh-Aa
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:24:10 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21670dce0a7so126445335ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736879046; x=1737483846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fNhJqhgmOjGG1DKeQwyyrZlriqsVHzvgw+5Rd351Gy8=;
 b=Unigh5mc0Bs/zUd5szrRT79a7NYgL7HSR8S+VPesJ8cpl+bpBiJ2y/6GzSLqXHJuEj
 05vzeaa5+o2+BOmQbNAEW87SNdNjoasl3B851R4S1CWdQ68LK6V2BovtxzQRHr4HpQN5
 pMXHx5eZo0+1uug5QaQH27m1YdhmEk17j7NEP26ovvIgB2Zw3AAslxmlFvrXeXAoIxjw
 U1PM6dbirnZEs2rcfEobKWMQe/7EreSTKYaZBVkNKDdCFRrMWL2Sfprj0D3eGQNXeh3I
 YYmpWG6vAMctHwsJDTliLICs0dDJFrEmDbVx8N+nNK42lKvQ3dqziLmLtLoVa7eIjzvF
 7OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736879046; x=1737483846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNhJqhgmOjGG1DKeQwyyrZlriqsVHzvgw+5Rd351Gy8=;
 b=Y3UUidpHcy7ndYgKlQZK4Q/BdZ95Ry2gjWxzcdAoG5/utYk2xoHaMieENHpoJIII7r
 mTOm4KcgT0UAc1+TSGeHnanS08ExQ0NbUQ8GlPFOgjCwenmxKFjOzxMPggdE/qPLPkJO
 Ni1UA4i0nibUbsjrR7LwmVDV/vG8X8OTRFgH4c/1bOcR4dv/d9Dz4+Kv/R4mdesV9hXc
 XKfSmgYoAnPEaxgxWonyauRPeuRWgFcZXkX3oQsTK8TtiOCCVySb3vlaLrm8o6WooO8Y
 +vSwh6zNoLyI6ZVXRIRGXCMRXQZuBwEQRFEftKLfNeootkkOdlSZ0JkHyBkyjXbHi4Ju
 N7ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDlPFGtLlEL7DIoGqnb/z00AuE+tqZLmlVHpD2kL8ibUgOUVfxPM2RTiHcrXp+hF8ZN7SWJD2hyiSs@nongnu.org
X-Gm-Message-State: AOJu0YwJP4W8fUBZgZfpbS0tAs29mrcs4OE6ONDelbjPB4OiEE/5Bt28
 T1iLFM+FqsPjK0YvI2KfCbuU2qp/h5Ix5C0gN0KSPqMhwvNXeG0v85rZ/+7v5fE=
X-Gm-Gg: ASbGncs0ihk7UyLeZ40N1JAX7ZvRCzfj+3J+AziJmUF1DFX34kuhgiF+GdiSgZpcbY3
 bWuLWpfIkLEzD7lypsUm7DuGXCAHvd5HAqFoj8whxn3eoSFvjMkk32aOvjuWZOapCIUeTUqt27/
 1Lfmap1RZh5MIPkm/pzHG+/fdWXJ6yGdxZ7N1OcLwyAtySxZQ4srkp0GompIStHYKu3AejntJY5
 StqxjyW2T0CQriRDSPFVUOzh8a9CrJ/6NmeEyko2GXuBu4PxNrfjmVzK9sNy7/ZA08JDA==
X-Google-Smtp-Source: AGHT+IHQykUXvhPdxMyHVApAcsnOrBNR0uwu1Sa+KztRfi2vL0PQyJkCdGEOCKZFqVte1RBmn5hmyA==
X-Received: by 2002:a17:902:ecc5:b0:215:bf1b:a894 with SMTP id
 d9443c01a7336-21a83f76704mr407767755ad.24.1736879043994; 
 Tue, 14 Jan 2025 10:24:03 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f262d80sm69942815ad.254.2025.01.14.10.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 10:24:03 -0800 (PST)
Message-ID: <55ceadf4-9bf7-4666-9d9b-7ba9ee526cf9@linaro.org>
Date: Tue, 14 Jan 2025 10:24:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/37] include/exec: fix some copy and paste errors in
 kdoc
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
 <20250114113821.768750-30-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250114113821.768750-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gMS8xNC8yNSAwMzozOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBBIG51bWJlciBvZiBj
b3B5IGFuZCBwYXN0ZSBrZG9jIGNvbW1lbnRzIGFyZSByZWZlcnJpbmcgdG8gdGhlIHdyb25n
DQo+IGRlZmluaXRpb24uIEZpeCB0aG9zZSBjYXNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5j
bHVkZS9leGVjL21lbW9yeS5oIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2V4ZWMvbWVtb3J5LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4gaW5kZXggOTQ1OGUy
ODAxZC4uNjA1Njg3YmVmYSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5o
DQo+ICsrKyBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KPiBAQCAtMTE5NCw3ICsxMTk0LDcg
QEAgc3RhdGljIGlubGluZSBib29sIE1lbW9yeVJlZ2lvblNlY3Rpb25fZXEoTWVtb3J5UmVn
aW9uU2VjdGlvbiAqYSwNCj4gICBNZW1vcnlSZWdpb25TZWN0aW9uICptZW1vcnlfcmVnaW9u
X3NlY3Rpb25fbmV3X2NvcHkoTWVtb3J5UmVnaW9uU2VjdGlvbiAqcyk7DQo+ICAgDQo+ICAg
LyoqDQo+IC0gKiBtZW1vcnlfcmVnaW9uX3NlY3Rpb25fbmV3X2NvcHk6IEZyZWUgYSBjb3Bp
ZWQgbWVtb3J5IHJlZ2lvbiBzZWN0aW9uDQo+ICsgKiBtZW1vcnlfcmVnaW9uX3NlY3Rpb25f
ZnJlZV9jb3B5OiBGcmVlIGEgY29waWVkIG1lbW9yeSByZWdpb24gc2VjdGlvbg0KPiAgICAq
DQo+ICAgICogRnJlZSBhIGNvcHkgb2YgYSBtZW1vcnkgc2VjdGlvbiBjcmVhdGVkIHZpYSBt
ZW1vcnlfcmVnaW9uX3NlY3Rpb25fbmV3X2NvcHkoKS4NCj4gICAgKiBwcm9wZXJseSBkcm9w
cGluZyByZWZlcmVuY2VzIG9uIGFsbCByZWxldmFudCBtZW1iZXJzLg0KPiBAQCAtMjUxMCw3
ICsyNTEwLDcgQEAgTWVtb3J5UmVnaW9uU2VjdGlvbiBtZW1vcnlfcmVnaW9uX2ZpbmQoTWVt
b3J5UmVnaW9uICptciwNCj4gICB2b2lkIG1lbW9yeV9nbG9iYWxfZGlydHlfbG9nX3N5bmMo
Ym9vbCBsYXN0X3N0YWdlKTsNCj4gICANCj4gICAvKioNCj4gLSAqIG1lbW9yeV9nbG9iYWxf
ZGlydHlfbG9nX3N5bmM6IHN5bmNocm9uaXplIHRoZSBkaXJ0eSBsb2cgZm9yIGFsbCBtZW1v
cnkNCj4gKyAqIG1lbW9yeV9nbG9iYWxfYWZ0ZXJfZGlydHlfbG9nX3N5bmM6IHN5bmNocm9u
aXplIHRoZSBkaXJ0eSBsb2cgZm9yIGFsbCBtZW1vcnkNCj4gICAgKg0KPiAgICAqIFN5bmNo
cm9uaXplcyB0aGUgdkNQVXMgd2l0aCBhIHRocmVhZCB0aGF0IGlzIHJlYWRpbmcgdGhlIGRp
cnR5IGJpdG1hcC4NCj4gICAgKiBUaGlzIGZ1bmN0aW9uIG11c3QgYmUgY2FsbGVkIGFmdGVy
IHRoZSBkaXJ0eSBsb2cgYml0bWFwIGlzIGNsZWFyZWQsIGFuZA0KDQpSZXZpZXdlZC1ieTog
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

