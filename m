Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6574AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 20:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whvGq-0001qT-7f; Thu, 09 Jul 2026 16:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whvGo-0001qB-Ms
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 16:22:54 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whvGn-0007Ka-5A
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 16:22:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-848595b338cso213550b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783628571; x=1784233371; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=er2nd01K52fzoSCDKuPe6L+4tKyOrTAJPVN5CW28/d4=;
 b=jSYpQXQKWHL/vQK39bDSAYu/W/zP32QKBVs9KtTuJg9xH1KIo/jsyd/7QOyF0ldBQi
 Mj0nvQkvrC94kb1kv4n84IEhyIXFyQqWbRbPCWzoTSqTByF9UEOxl5/jskJiCRjmGTm6
 0nKQrdRSZ05nafXSvWAbY8XnJpt5BJCWQo90+w0T0qJB7po0PqUtN8NyMF6/7Ot1o+rg
 14mkwKcnavhJBdrUkI/fOBPpsm4McIOnxJZUyEecDeEOxywSwDCY/rzqHq90fYKWVWJ4
 ZbRqeygxHWm/Pwa+CIQQfnejYVL9MQGz2VYSUuylRtOW2kf/5nry5jXLX69EM2j9cv5g
 W1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783628571; x=1784233371;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=er2nd01K52fzoSCDKuPe6L+4tKyOrTAJPVN5CW28/d4=;
 b=JlHYUzZR5kB4vPxChpQ1mcZdQj6y/xIHGx172NSQKZK46TCZKCyI7RxEWPorQfFSEM
 HAT24PSz0NR20QX57kCPBA+rwZVF1oYws8GZFG8CfP3Kxrm+AvZ7bft/k9I70Iwc9/BR
 DEHcNyrMultdpuq+S3Yjx2/QIWS3vaYndk/1uMSQ6uofcOZN1nMawBV0fKih/m+y+wmQ
 Pv/IdaNduyebbWFv53PUgLcbWgCQ12lXCZ5sXHkZv+L9ShwFjV8gkwJ9IJcdYPO43Cmm
 PDeOfNOisuvwiSJ/QcACCRA3617xWQkk+w/mEHCPH8cnG5zqXEun4k7Xe9Z5LVjfWngP
 ydlA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrl7NLEIKkItIKRbznsyWNBb2GhscOdvU9aRCKHToePI88D/RMzQ+hXNFVDAWZ6Az0Xfzzyy55L6YjE@nongnu.org
X-Gm-Message-State: AOJu0YwinZIekGBDPZGg/o8i4cjZ/yu5/yWh/1bNbFnl7zlYy4YlCFJC
 KwZQH7T5gCrngWKBP8+4N8oV9qJkgTJcKzpWwuG9vJWqFZzQa2yBjIPed25nOf27pvU=
X-Gm-Gg: AfdE7ckAN1XYCoPeZRFF6QnXTCPFBrPGyG3/gXCTcKeNTMiNvPsSevJl/oqWKWj5Yzb
 UtrvgmNOOsEmArC+xC5pZ7DVCeaOBqeo1/FpEktqENjc73DfUx/Eup0PW8K5XIgAC7+XLqIgkCy
 6l8KCiQmpObSRdlZmuI6LjEixdlQRYiUAB1Lc4bRhaMIQ7Mt36ctJBC7LOJP+0eaxTxu1IStEFw
 H7QAjTKXxYFETKuGlKavqB2ev2OU4G+YAEd8AArB4fG+BxBARwH62x+pAEQDGueGHqniGgP+unE
 dlhFqMlwdEJ+tXovAZtgznAW4tsLyleFKbSSKOFbVSzUkCZG43hajF/3qbfJUTD+pxjgDkqkdi7
 qszFInjD0/XFIdKIM/o1+XgSRZbFVqw82En/1/S/8GIvyd9SKWrgJyxntASHdStslcRaK7vgaHx
 B9NZYo6ai5XsFabB3b
X-Received: by 2002:a05:6a00:91d6:b0:848:44ae:47c1 with SMTP id
 d2e1a72fcca58-84844ae87b9mr7146613b3a.78.1783628571139; 
 Thu, 09 Jul 2026 13:22:51 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2f15:8249:27c4:1b26])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d4dbdesm9126916b3a.31.2026.07.09.13.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 13:22:50 -0700 (PDT)
Date: Thu, 9 Jul 2026 14:22:47 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 03/25] target/arm: Add confidential guest support
Message-ID: <alADF-nLnPH53uWO@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-4-mathieu.poirier@linaro.org>
 <87bjcim6x1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjcim6x1.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42c.google.com
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

On Wed, Jul 08, 2026 at 06:39:22AM +0200, Markus Armbruster wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
> 
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >
> > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > support the Arm Realm Management Extension (RME). It is instantiated by
> > passing on the command-line:
> >
> >   -M virt,confidential-guest-support=<id>
> >   -object rme-guest,id=<id>[,options...]
> >
> > This is only the skeleton. Support will be added in following patches.
> 
> Which of the patches add options?

Good catch - options have been removed because they are not supported on the V14
kernel.

> 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 

