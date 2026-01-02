Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE45CFA3753
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 16:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbi3C-00062X-QQ; Fri, 02 Jan 2026 11:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vbi3B-00062B-Do
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:30:53 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vbi3A-0002Tq-3W
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:30:53 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8888a16d243so107268366d6.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1767371451; x=1767976251; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pSR8hK8tTK4KHjerI4WC8ZZ/sjvcize5Fa2sfEtgqOU=;
 b=vRE4Xn+sMWl2oDb4AsfttlDN6ERTaqoJdpv4vvjPsJMDIOSAztp0VWVDufuUymjcuF
 NizADe9yr9XGzDZvV0IqH98INW+Z+e6naFLZh2JfB9zO5W3iis8b3lG07ig/T6q66ZqK
 BTf+8e2aMFaRd09pTUgftWmY2CtrpioIarmCdDDiNAt14RS/Fbut7PNxtSqxcxCr5wdC
 h9Ntmx84kijz3PusgETq2M1/yTwRqXLG9kfyCwNJpZkX97BfwB5ygYV/yl/a44MdMpFO
 RvuwNy1UewOHfn3a6U2lBiAIAwMclkN60eAUYjGmRWCgQFR0CkRiiFGKaiGvGZlrydQw
 XFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767371451; x=1767976251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSR8hK8tTK4KHjerI4WC8ZZ/sjvcize5Fa2sfEtgqOU=;
 b=pT0GZ/Qk1tFzzJnJ30YTtFEj3DzLKVi9RHMEUiRIrxDkgQc9Dn9MfGnf9rybJN8xoS
 d50NrpgoY20tkAn1DXYWmiM1PGJ+94unZ2i+C1E3Pj34lj+WTy+tj+k8XvN8UmnsGAjh
 6GxA6ob7wwhoknmPG8spntyIgi5luykLSHCSsAHQ0dTQ+/o+MMO1D4dWqqk7wJnLPw6m
 tjISzg8X51JieupNNVqmizXxfTZnAiZc/8zuX/mY8PncQ1g8Aas+/0g44LstgQtkV2B4
 5XyhB+nM1DaCrlIqGXVsYy2qEurJG9XDoSJSULBbJzC7HC59px/DRPjvQmy8/MO2wIqF
 Ln2w==
X-Gm-Message-State: AOJu0YxSCOzQhYljTI2O5zsJ8n3+uoDyYRPCVGQJ2U+Us65dWEHZWMOb
 lhhF53ArD6KTBMeTCW7hqxWUZ/XmQcjoY/0N79eOiED9gLEE45dgdtrmg5EeNJjyzPk=
X-Gm-Gg: AY/fxX7V5bw1nzsQ29NVvIFL+RYrvzBNIq4qge9Aaz21CrFHoqJ2WhmI/fw7VwSPwud
 lt5Zez1mv8i/q5Hyg9YRyfu8idrfiEx6l5HgJfF9wWrQ/C8yRYGMOzOkWjDqONiiWgWMH9Gv/H6
 2GoeToheVNU1XzfFXKMw5uMBeCh7el4uLCLr4uZ5rqyUSvpl/93HgO/UJkGzs3ImZKyOw3eJYva
 NYMD+rfNHh6sJwWmlHdObdB/gzIe4JsZgGqx/Sz3429ac0xmWuegFgFxx0w9+x78R1cAo3bEYjL
 5gNwU179Q0GHJQ6Vzxpu3jlAQ2E6GAblkgvd4CZnRqyCgYjo7yNHuM04DyV+wP1uc4uL9w00nWm
 JXp8Cx/yiSqt6++f8B2ZonXluMl98XznNT9/JY84+kxlN8KfTRJ173E9+UK+1363mnTHJIrhCO7
 pzwQjscfXzXXT2dKJSWV7oxKqD8McuvIslw7z++zGXV3vNH/lb+vTz/tfe6prBHLJZ+Tte0A==
X-Google-Smtp-Source: AGHT+IGRXvL6hjlMMJygN6D2S3EfBaQ+pnBh9jKM5AtS3XCFICf2fMpA7K5+0CeMTehdAqD0JJx8PQ==
X-Received: by 2002:a05:6214:428f:b0:7ef:d35f:e1e3 with SMTP id
 6a1803df08f44-88d87be974dmr664648026d6.57.1767371450788; 
 Fri, 02 Jan 2026 08:30:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d969fed73sm299315916d6.15.2026.01.02.08.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 08:30:50 -0800 (PST)
Date: Fri, 2 Jan 2026 11:30:15 -0500
From: Gregory Price <gourry@gourry.net>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <aVfyl8sylMICO4mc@gourry-fedora-PF4VCD3F>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf2f.google.com
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

On Tue, Dec 09, 2025 at 05:38:40PM +0800, fanhuang wrote:
>   -numa node,nodeid=0,memdev=m0
>   -numa node,nodeid=1,memdev=m1,spm=on
> 

Should discussion with Jonathan - whatever form this ends up taking, can
we change this from [on,off] to [normal,spm,reserved] and apply the
appropriate types accordingly?

don't know what to name the tag in that case, something like..

memmap_type=[normal,spm,reserved] ?

(not married to this, open to suggestions)

~Gregory

