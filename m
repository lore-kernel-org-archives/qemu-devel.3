Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E6CD6555A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG35g-00014j-CU; Tue, 26 Nov 2024 16:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tG35d-00011X-Az
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tG35Z-0004Ik-JQ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732656435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bVfuVSIsMKCKvriHIIacA8lNNZ42nxSlyRz3CpsIdY=;
 b=LkKuaLb+SmCQwLYB/uG74RmTElYfNa1HZVhZ1A3q8zGDPPZN4YM+8+EpHOdJEccPDpDheo
 2TB+P3RgJZEmVwYP/p+u+UIKEpAF1OUPb70tshIoW+/xapDMzIni5wRZTAax5Q4EA7As1C
 8VmXmDPDMAZHjQs8tZpgudlJR/OHcgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-h3-1b8YDPFCHc0S2WUVd8A-1; Tue, 26 Nov 2024 16:27:13 -0500
X-MC-Unique: h3-1b8YDPFCHc0S2WUVd8A-1
X-Mimecast-MFC-AGG-ID: h3-1b8YDPFCHc0S2WUVd8A
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4349d895ef8so28639675e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732656432; x=1733261232;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bVfuVSIsMKCKvriHIIacA8lNNZ42nxSlyRz3CpsIdY=;
 b=kg1hsjF+tDyLQNqB7QvLpkYss1IHAs4ntxAawZDycIPFZKrRVLCpuSFuv1Y0hl9CY4
 V5Tc//mMqwFiVnZmUsnDDd+nWKtcqL0hBy53kn6dEB1GUNxZnh6DSidOVIqt68HGMBZZ
 3yoc48shJjipOOZg7duRKfEeLdopfkFYa2JxKlYU/lo4jQbvLOj5Fgg/xQ728OlWTnyT
 2tjNeiSkIqPibgCtEH4a9XBIHfgfcmRiEHRndmAn1JytU7+ETZ/jNisbIyPAlsjMjcrw
 VP3VeFjGPcXaECNLkuRCuBCrMx6FhP0Q4WhSMSViQF3eoWEs5dBxc3zORM4ESujqxsLr
 pJDw==
X-Gm-Message-State: AOJu0Yy7LwlBp1pVHLT70bc6fKUkO+P5l3Nguh/bdtokkon7dOR7yBfV
 eWSduBzkoJrn4Y3PJMcbQ87yLIi2siGJKt1PPQk7vgIuYwbcCq23JFDy4gTCJWT2LOlh264D3+P
 V+cBT/xn85pkAR+hREv93+43ppzcfo0f7iLMiXwBJ2GTcHmHUNxPH
X-Gm-Gg: ASbGnct3EHkxbZk5f26KQT8J6JjmJWxSA4e5MWYZpDaxSxJjwdo3d+Y+bejeImFijGD
 H43B2+RwMqII10RVFreqcbtReF85xLlNpWhwPSiCv3S+T60ywBwlBZU10IpOXy/S/uSTJ+xNlay
 u1nahszBBTWPC4U9qzeMAGhOnHq2E9JrQD5jgmCsn8ELF2HAkUwAqM1iaqBjF8Qru55obuT5dB9
 9VQvj76wBIzM4S5tZOTfpX05IjouV7pHN24B1HBlQ==
X-Received: by 2002:a05:600c:2244:b0:434:a8ef:442e with SMTP id
 5b1f17b1804b1-434a9dfbafamr7729015e9.31.1732656432476; 
 Tue, 26 Nov 2024 13:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjgz2FgrmcINdKkoJfxex3YuSbGP/iA9vAVXo29xmjdAJIdEMvCSbnI4EQsP07JMl9b42HoA==
X-Received: by 2002:a05:600c:2244:b0:434:a8ef:442e with SMTP id
 5b1f17b1804b1-434a9dfbafamr7728705e9.31.1732656432034; 
 Tue, 26 Nov 2024 13:27:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:4654:4e59:b33:d0e:9273])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349ea54e13sm95116915e9.34.2024.11.26.13.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 13:27:10 -0800 (PST)
Date: Tue, 26 Nov 2024 16:27:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 39/39] docs: explicitly permit a "commonly known
 identity" with SoB
Message-ID: <20241126162651-mutt-send-email-mst@kernel.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-40-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121165806.476008-40-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 21, 2024 at 04:58:06PM +0000, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The docs for submitting a patch describe using your "Real Name" with
> the Signed-off-by line. Although somewhat ambiguous, this has often
> been interpreted to mean someone's legal name.
> 
> In recent times, there's been a general push back[1] against the notion
> that use of Signed-off-by in a project automatically requires / implies
> the use of legal ("real") names and greater awareness of the downsides.
> 
> Full discussion of the problems of such policies is beyond the scope of
> this commit message, but at a high level they are liable to marginalize,
> disadvantage, and potentially result in harm, to contributors.
> 
> TL;DR: there are compelling reasons for a person to choose distinct
> identities in different contexts & a decision to override that choice
> should not be taken lightly.
> 
> A number of key projects have responded to the issues raised by making
> it clear that a contributor is free to determine the identity used in
> SoB lines:
> 
>  * Linux has clarified[2] that they merely expect use of the
>    contributor's "known identity", removing the previous explicit
>    rejection of pseudonyms.
> 
>  * CNCF has clarified[3] that the real name is simply the identity
>    the contributor chooses to use in the context of the community
>    and does not have to be a legal name, nor birth name, nor appear
>    on any government ID.
> 
> Since we have no intention of ever routinely checking any form of ID
> documents for contributors[4], realistically we have no way of knowing
> anything about the name they are using, except through chance, or
> through the contributor volunteering the information. IOW, we almost
> certainly already have people using pseudonyms for contributions.
> 
> This proposes to accept that reality and eliminate unnecessary friction,
> by following Linux & the CNCF in merely asking that a contributors'
> commonly known identity, of their choosing, be used with the SoB line.
> 
> [1] Raised in many contexts at many times, but a decent overall summary
>     can be read at https://drewdevault.com/2023/10/31/On-real-names.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> [3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
> [4] Excluding the rare GPG key signing parties for regular maintainers
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20241021190939.1482466-1-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  docs/devel/submitting-a-patch.rst | 7 ++++++-
>  .gitlab-ci.d/check-dco.py         | 5 ++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index 83e9092b8c..10b062eec2 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
>  
>     * - Check
>       - Reason
> -   * - Patches contain Signed-off-by: Real Name <author@email>
> +   * - Patches contain Signed-off-by: Your Name <author@email>
>       - States you are legally able to contribute the code. See :ref:`patch_emails_must_include_a_signed_off_by_line`
>     * - Sent as patch emails to ``qemu-devel@nongnu.org``
>       - The project uses an email list based workflow. See :ref:`submitting_your_patches`
> @@ -335,6 +335,11 @@ include a "From:" line in the body of the email (different from your
>  envelope From:) that will give credit to the correct author; but again,
>  that author's Signed-off-by: line is mandatory, with the same spelling.
>  
> +The name used with "Signed-off-by" does not need to be your legal name,
> +nor birth name, nor appear on any government ID. It is the identity you
> +choose to be known by in the community, but should not be anonymous,
> +nor misrepresent whom you are.
> +
>  There are various tooling options for automatically adding these tags
>  include using ``git commit -s`` or ``git format-patch -s``. For more
>  information see `SubmittingPatches 1.12
> diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
> index d221b16bd5..70dec7d6ee 100755
> --- a/.gitlab-ci.d/check-dco.py
> +++ b/.gitlab-ci.d/check-dco.py
> @@ -78,7 +78,10 @@
>  
>  To indicate acceptance of the DCO every commit must have a tag
>  
> -  Signed-off-by: REAL NAME <EMAIL>
> +  Signed-off-by: YOUR NAME <EMAIL>
> +
> +where "YOUR NAME" is your commonly known identity in the context
> +of the community.
>  
>  This can be achieved by passing the "-s" flag to the "git commit" command.
>  
> -- 
> 2.39.5


