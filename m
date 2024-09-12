Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743F7EE57F6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 00:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soXhN-0005mB-I1; Wed, 11 Sep 2024 20:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soXhM-0005hy-HU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 20:28:36 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soXhI-00004q-Ox
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 20:28:36 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7db0fb03df5so324193a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 17:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726100910; x=1726705710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c9o7/Cb/II9t2dUk/lFV7V5FBEJVmX+kPV3LL4olG50=;
 b=znjPXYUfrXae5YZSAkTQLgp5O1wEpkKfGRwsM0yT2UrG/8JQK2WkcGAzSEuPwm03Na
 +F+S9h9vzMWuWoFoxy7g0NB/B6611+ACzoHTpR8RAPzh0eIyp3TmST404r8vz3R0VTZi
 ywdaGbcZG9VfqG11A0Bg8pHcOaAYsQgteLLY7NBcUZG6Wakr+NjkRAhqRVl4pNb9mNQm
 3o8AweN2YppTu8O69NCoK0x/aqsMKZn7d9/+pZf+xcC13hE5kQVISSWfdhLSXl+chBQA
 4ddSIJFuGB37YINBa+sBueCTcaVrZUoVna/C28S5RR8edNG10n/tVSJE253ZjmCsmC+m
 l57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726100910; x=1726705710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9o7/Cb/II9t2dUk/lFV7V5FBEJVmX+kPV3LL4olG50=;
 b=mn45A3K1fAFTlsKR7OfSctopO1bgJRd8bk0j+JTqKgVs5JGKv9L3o/ni5YhJsrK5vc
 8mKcLxVycpqlvzU860HDYgdtRXEtZaVpnnEuf6vrdZbBa1klKaO+MXikvXkMtGEp27dN
 nLdLhjYaA73c4hx1R4Gl2cZD190+2B3qqR1KBdH7qCv0RBYbczpxCNs+khY+wwTibzxx
 G56nt2LBRVLR+Zovhy6s2Zou2Ssx1njrbTpZ1Fkf+W2xs02FdpGXD6d6oElfPZHj9Ewk
 M8frLg0odbN3GzZ0oz/AmpjJs1IJgabNsEzYwNOHSNbK5gnbjmCZL8N9eoOu83uKex9h
 y6JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWTAePuyYW7nIbeZFGffX64VlCOZeitHI9uYs1kAv+oTgsy5wxJmH2aBANG3Gpfmzb1G3FmMQUQtYK@nongnu.org
X-Gm-Message-State: AOJu0YzZponyoy1iBZv+vyxkQahF72PKYHGDQK1F0nind1ogDM8HKEsB
 FD6jtaN72W+rIig8VsW3eFUMauUf0KH9wcO+gPF4ppyTnC+W8pEnZKmpaMIWgWc=
X-Google-Smtp-Source: AGHT+IG/+agFR+owCifK6LN7nBFHTLHqk0umycTEk4Q5c9uh7VrVH7bVyDXkjOez5N5fvomBj8Vk0w==
X-Received: by 2002:a05:6a21:4581:b0:1cf:4458:8b27 with SMTP id
 adf61e73a8af0-1cf764afde6mr1438134637.46.1726100909723; 
 Wed, 11 Sep 2024 17:28:29 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090c37efsm3523445b3a.187.2024.09.11.17.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 17:28:29 -0700 (PDT)
Message-ID: <7328179f-dbc8-46da-8b87-1077a706acc7@linaro.org>
Date: Wed, 11 Sep 2024 17:28:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/39] docs/spin: replace assert(0) with
 g_assert_not_reached()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>,
 Eric Farman <farman@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-2-pierrick.bouvier@linaro.org>
 <zkyoryho5alnyirnl7ulvh5y6tkty6koccgeygmve42uml7glu@37rkdodtlx4f>
 <bwo43ms2wi6vbeqhlc7qjwmw5jyt2btxvpph3lqn7tfol4srjf@77yusngzs6wh>
 <10d6d67a-32f6-40fc-aba9-c62a74d9d98d@maciej.szmigiero.name>
 <20240911125126.GS1450@redhat.com>
 <c62bed1a-a13d-49eb-aec2-54bfe78dd1e5@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c62bed1a-a13d-49eb-aec2-54bfe78dd1e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/11/24 09:13, Thomas Huth wrote:
> On 11/09/2024 14.51, Richard W.M. Jones wrote:
>> On Wed, Sep 11, 2024 at 02:46:18PM +0200, Maciej S. Szmigiero wrote:
>>> On 11.09.2024 14:37, Eric Blake wrote:
>>>> On Wed, Sep 11, 2024 at 07:33:59AM GMT, Eric Blake wrote:
>>>>> On Tue, Sep 10, 2024 at 03:15:28PM GMT, Pierrick Bouvier wrote:
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> ---
>>>>>
>>>>> A general suggestion for the entire series: please use a commit
>>>>> message that explains why this is a good idea.  Even something as
>>>>> boiler-plate as "refer to commit XXX for rationale" that can be
>>>>> copy-pasted into all the other commits is better than nothing,
>>>>> although a self-contained message is best.  Maybe:
>>>>>
>>>>> This patch is part of a series that moves towards a consistent use of
>>>>> g_assert_not_reached() rather than an ad hoc mix of different
>>>>> assertion mechanisms.
>>>>
>>>> Or summarize your cover letter:
>>>>
>>>> Use of assert(false) can trip spurious control flow warnings from some
>>>> versions of gcc:
>>>> https://lore.kernel.org/qemu-devel/54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org/
>>>> Solve that by unifying the code base on g_assert_not_reached()
>>>> instead.
>>>>
>>>
>>> If using g_assert_not_reached() instead of assert(false) silences
>>> the warning about missing return value in such impossible to reach
>>> locations should we also be deleting the now-unnecessary "return"
>>> statements after g_assert_not_reached()?
>>
>> Although it's unlikely to be used on any compiler that can also
>> compile qemu, there is a third implementation of g_assert_not_reached
>> that does nothing, see:
>>
>> https://gitlab.gnome.org/GNOME/glib/-/blob/927683ebd94eb66c0d7868b77863f57ce9c5bc76/glib/gtestutils.h#L269
> 
> That's only in the #ifdef G_DISABLE_ASSERT case ... and we forbid that in
> QEMU, see osdep.h:
> 
> #ifdef G_DISABLE_ASSERT
> #error building with G_DISABLE_ASSERT is not supported
> #endif
> 
> So in QEMU, g_assert_not_reached() should always abort.
> 
>    Thomas
> 

Yes indeed.

For further information:

g_assert_not_reached() expand to g_assertion_message_expr(), [1]
which is a function marked noreturn [2][3], so indeed, it always abort.

[1] 
https://gitlab.gnome.org/GNOME/glib/-/blob/927683ebd94eb66c0d7868b77863f57ce9c5bc76/glib/gtestutils.h#L274
[2] 
https://gitlab.gnome.org/GNOME/glib/-/blob/927683ebd94eb66c0d7868b77863f57ce9c5bc76/glib/gtestutils.h#L592
[3] https://docs.gtk.org/glib/macros.html#compiler

