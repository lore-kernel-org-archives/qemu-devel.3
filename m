Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB97ECD993
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo473-0001FU-Aa; Thu, 05 Feb 2026 13:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo471-0001Ep-Jj
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:29:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo470-0003yu-6j
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770316193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NE4DeFo9dpF/9z6VLnsKdlqHl1l8ZBzQ/WXXYipoGpA=;
 b=CXKyoUx+0EgamyWmBXzu3MvR9BwyCvuJ3RmKtSb39RJlDua0XfcIidfY2Q4z/LjbU7fXqX
 H+AtEbAyg4fyv9quDNwCoo5aLFaz10URsVM+F/wJHiJvcYnsfzKNoAKyyWLw5gUvia0K01
 xESXET6iVtpqRiq761W5oswaIKElnXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-lG6RNHQ2OAKgrNvYz1EIZQ-1; Thu, 05 Feb 2026 13:29:52 -0500
X-MC-Unique: lG6RNHQ2OAKgrNvYz1EIZQ-1
X-Mimecast-MFC-AGG-ID: lG6RNHQ2OAKgrNvYz1EIZQ_1770316191
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43623cfb160so505346f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770316191; x=1770920991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NE4DeFo9dpF/9z6VLnsKdlqHl1l8ZBzQ/WXXYipoGpA=;
 b=esHIahwILxH19SiRVNaa/22SgVNq4KTnNWWDi/t1xAxRvF1WMnicljBqeRlozQZU9G
 v+jyYbUsUkunbCOUZpauxK4yDJJGdHJog7NqlPVyGRza3ZPNAd6koG8zTMOk05qUGy7i
 DuYyfqKawojNF0lJOhCDOJgDBb7OING8UHAihfgm45R09dqmfCxFTMwWbZAuxSK9mnpA
 BjhMyP31mvnXk41fKrP1XLniwxkTQDhjs6NckI4MsojilSSLRTNHEnV3UeMQEQWeiPUj
 YivLuBnzRdhlng5sExbxifcjw9ynGU/5DSfd75bd0mpy66v91BAVOsmBc0feYL/fji+p
 5hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770316191; x=1770920991;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NE4DeFo9dpF/9z6VLnsKdlqHl1l8ZBzQ/WXXYipoGpA=;
 b=gd4fG3FDZqU71MfZGlpKvzurtCK98gvShxSoa7qyNvDs0xCvDyX4tpcADqjN7CA92f
 A+ivebsiUgTgRStZTPbPt1smrTh2Zsf44k00Ai44GoD7n9v13vqtqRTDDwyhgWq4r0z2
 KD9f5H2nsBCqsdq0IscfWUjwhpWuQS9TPmSsBQtTp27t05sg8LoM3h3xi1oJC/F2GQ5P
 /TJ5xMtnFyzyBkT6lbZ8staIacEM7Ztclp58NmdNaqJ/Cdd1lfe6+UowmOKcfsTpglMh
 fF6OM53wdqscmslhe0gCqElxa6W04tnuEfHRIYx4+k9UvCnaEr3aZnZk9hae6cRCQ252
 dfPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1d1K9C8HUvICSr4a7HknmjChqVhW53WpFxkUZRkttRkV/YMVCKkXTFQx5oyNddlIu0nQvL/51ulf3@nongnu.org
X-Gm-Message-State: AOJu0Yw86UNe5LQ5CNs3Va9PwYQ446phns01Szl9IOX0EOCtDdkikEN4
 kW8pzzyshV+21gGxpgcqbP46B4na+9dXTxovUdJTh6cWUIlhcMgWiyv0UwTEsLbZdzKfDSTAjvm
 WZ++z2kfKK7vzzto7HEroHE756WWVkdVODdkVKAy63mlDwEh7h0ZRx2x/
X-Gm-Gg: AZuq6aL8dWT+0tH21gpt6gydZYuiDGbP0BDvH56SaOGeMzUCtFy4tPH4925Lq5oCQAW
 /sEXh1geI+6r5YfeGaHnpg5z0JRPcAsQm2Isu1KRmhN+XDS4R+Y+nrpEjMJ7Aun620bZVzB4PD6
 YKJCgb3Fy8TfyrmJuS2EsmCjxRF4A7bYC7PI4Sydi5ejissvJNm5y2RLqUfMM2Odh9txHpZF7EX
 lEwpkdvZyFfeKeWzEiwviI9OVXPdhlttu5t9OeHowLozUWCkHWztFAyTSkdQnNztTicaRJh4Lty
 NS344vil0WNRmQXILqYHcijxz0HMqGcJbi6RUI/pwBgP5i+zEmg3MksjL6c5FyibhB/1a0y+Tfn
 x98M054E=
X-Received: by 2002:a05:6000:310a:b0:435:9abb:2e16 with SMTP id
 ffacd0b85a97d-436293ba942mr278053f8f.45.1770316190880; 
 Thu, 05 Feb 2026 10:29:50 -0800 (PST)
X-Received: by 2002:a05:6000:310a:b0:435:9abb:2e16 with SMTP id
 ffacd0b85a97d-436293ba942mr278012f8f.45.1770316190501; 
 Thu, 05 Feb 2026 10:29:50 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629756ff1sm34186f8f.43.2026.02.05.10.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 10:29:50 -0800 (PST)
Message-ID: <4852f5ed-7f9e-48c8-8882-91c7c42e5dc2@redhat.com>
Date: Thu, 5 Feb 2026 19:29:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] target/s390x: Build system units in common source
 set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260204182722.44062-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/02/2026 19.27, Philippe Mathieu-Daudé wrote:
> Except the ioinst.c file which uses the TARGET_PAGE_SIZE
> definition in the ioinst_handle_chsc() method, all other
> files in meson's s390x_system_ss[] source set don't use
> any target-specific code. Moving them in the other
> s390x_common_system_ss[] set to build as common objects
> ensures these files won't use any target-specific API
> such target_ulong / TARGET_PAGE_SIZE, thus forcing to use
> the appropriate types instead (such vaddr, hwaddr, uint64_t,
> ...).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/meson.build     | 7 ++++++-
>   target/s390x/tcg/meson.build | 2 +-
>   2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


