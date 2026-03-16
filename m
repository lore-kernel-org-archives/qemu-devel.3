Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EAEF46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25hY-0005kX-Nf; Mon, 16 Mar 2026 07:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25hX-0005iH-Hy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 07:01:35 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25hV-0000ne-Rp
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 07:01:35 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ca423ad53so4481115d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 04:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773658892; cv=none;
 d=google.com; s=arc-20240605;
 b=k4PQKLt6mWC1XrI2fM4kKXE5Zv1zxOCX4povbyRsvdxvOLhwUD3wQ30/o23kx+elnr
 /nVAFMF2ivaB7rw73M7iiFcAISjY3B2eW53J5PuVAnXAjeUqgJGVAT+TTJKvyNtDN4uk
 6XaqKjNxz2iNytj3Tx5wWVvVaKN4IjgTtbOPrQr3GUegQdMnDXyzvatIhkzC7/bbKZ/T
 3ntBei3yWwlL10ycVQ7L0ZoJnUUKXFwsVennZCzm8SfaQMhPgwJ0q3Cl2TwViLQsLYfr
 f5L1DN4Tg60qREf/pZrDTDqxLkHnhuKtHfeBezc4d3UW7Qrl5X60fJ/RUjNn5+D4gGI/
 YdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iajE5yb9GWAPq9zdhgQ9m62U7u6cK9RHCWPActK+nZc=;
 fh=lowJsqLkqJLhwPwA7LhiYfSfWEsxUTjr7bjtXmC+vzQ=;
 b=RRO2mzrBATvm5mZ10vFfyTZdUte+WtDVIx0EDqzJXCIp+9s1pWltvoVSbSFxmB3EOZ
 68UEerzY43ppKMo8MrFhupS90efCBuSN5CtKTkes5okMcLvxzrSCEXYyGHaEHdSUjTts
 TIyysPWYZjyPnOky0LdXISvGczkBWFt5FeNNUD6/lRYH7RVxG7udcw/lqZyShf39EfDE
 Vi266iAItMOrrQORFG/UT2n+XFNDOT5mVXBOe84dl0WiMR31XeZOZ2hNtUoio2R2CU/0
 a90hr4+KbWqq8z9SQsdQSbW6PDhIBrENi7ezaV/YJsVAvs8b9ZtnYakOd5pq/cQf5e3f
 wLcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773658892; x=1774263692; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iajE5yb9GWAPq9zdhgQ9m62U7u6cK9RHCWPActK+nZc=;
 b=fkejRN2mGlXyHNV+JJ00HrYJwVqesRJNzEWJVnIFL8nYbYN5eLG+KGvynSqDyrNv6n
 1FbRZ15JEIHgcx4f1+R3Q7Qi5SGJVphR/dAYppTuX6rDA5J+ugr5qguKr0h/0fzZfG4Q
 CXQrzgIGRaOq5j9zTuoUC2Al/6xb21RyGclx+D5w5opZp+/eBXZy/ihyuxTreA66300b
 Ary8IirQ4d4mJQWL3U2VPJh15Fjk6CyT6sT9st7bt7P65GncX+ZfF0stwcIjfSvwUJVW
 BX0ckEMi4cYQIefMF4gk8F6dev/dQW2rGtnaG5rZkFlfr1nLmeRp/2QK9xJGeo9N4K+1
 RPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773658892; x=1774263692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iajE5yb9GWAPq9zdhgQ9m62U7u6cK9RHCWPActK+nZc=;
 b=k/+tVTU91c2C+QJ7KGWIFZ6LWgfI7xc+W+BTnrg67TDtobUOII72qUJAr1x4W37uA5
 iEi6FoL6RHKe+DNHHXvbgalNGFpnU0LMZ+DeYtk4c5iOExZ86NZ9go1b9yjnMfJ/+1tE
 SqB3YTjsHuedy3DoSL67VvcXwR1BdkramEHC7L/fabTNjp3RQWJXiIPX2vYeICaUPc9V
 4zVEIGlIxhHk1V1D4pmDVPT30bSG7WVzX1WRQJqr/tq1M4m0ZBDG49CPV11HIDgJm9i0
 M36ulyCFTz8HcvaSNZ9TL42m4BWGp2mo2nOVulBC0xmTRZT4O/7PV988wqKJm8kBnUz8
 s2YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQc4wmPWNXgf+rOIHRO0t0XUInGnw/Z8LmoIlD4AFnKkpuAha91lCtZD49Of6GdswTDreOVr6gidPm@nongnu.org
X-Gm-Message-State: AOJu0YzfSv4GATJdMUxIJ/JnxNTfQVNseJJxLjZiRJEwqRyI9D8QYJlI
 13Ho2kn1wEQLH4x12Dxbojd3N6vXjGCNKAh/HGO8hRd/E4zknRQhoEDlxfqWG3XugbgfrF0w1bb
 5bUhEWQ35hY/VGMCn8Abn+q8NNhGNAOXF/DxryVO4bnMVZmgcwevQ
X-Gm-Gg: ATEYQzwr7CSD5DdvEWyHD88B5cWzBXKgx9LFipDKXAT122UR4HuUgYN4jBjT3AsgGl7
 dVJd9vc2azrMkTSm0kJkc0Y+Kuixsgw5ZoZxIebg/K9DlI/zMpFSHzg/V3N8gBIqqO3lpquo0J+
 nqSS7Knw4tbS+IIRTDy9unoi1nEu+IoJ0ATUQCitzX8jxEHbVvtwPMnBtXTtkDE06T5nTZQEO6y
 ooUk2DZ7xZdSbGdK/C5K/UDmyNF4pD62XFc4xkOyLGnhE3XywoRKq21O9cQmG8ZATqAvq/8EqCL
 DQCtDUmFK3104PipcyqD5u1hbWwxLPEDaxA7nHQnRo7TaaLdV4UY/nbEZc6dm9SRXXQ=
X-Received: by 2002:a53:d056:0:10b0:64c:ae15:5677 with SMTP id
 956f58d0204a3-64e62f3d106mr9534966d50.26.1773658892145; Mon, 16 Mar 2026
 04:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
 <20260129160917.1415092-15-peter.maydell@linaro.org>
 <CAFEAcA-AoJmHpcAydqk9x_Y6M8_7N=7-izYFPxerLuTdYUKsNg@mail.gmail.com>
 <CAFEAcA99c+-qQX+wfVTZ5bKeYozm+WrFHsb=GEQriu_SuWjhWQ@mail.gmail.com>
 <671d4604-9656-4f74-961c-88f447058858@redhat.com>
 <CH3PR12MB75485C08E7F94A214998914CAB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75485C08E7F94A214998914CAB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 11:01:20 +0000
X-Gm-Features: AaiRm52wv2FCKJnx6QQd2PYMbLHLMiWkhc5igPJA64ONKHf5HErO2_ZE6awwg2Q
Message-ID: <CAFEAcA_EeyJW=uhV5KEhoH+v32KG0UskmNAOW1kA-6hAB1S_yQ@mail.gmail.com>
Subject: Re: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Nicolin Chen <nicolinc@nvidia.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 16 Mar 2026 at 10:50, Shameer Kolothum Thodi
<skolothumtho@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Eric Auger <eric.auger@redhat.com>
> > Sent: 16 March 2026 10:36
> > To: Peter Maydell <peter.maydell@linaro.org>; qemu-devel@nongnu.org;
> > Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> > <skolothumtho@nvidia.com>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Subject: Re: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE
> > install/uninstall support
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On 3/13/26 3:06 PM, Peter Maydell wrote:
> > > Ping for opinions on whether Coverity is right about a leak here...
> > >
> > > thanks
> > > -- PMM
> > >
> > >
> > > On Tue, 17 Feb 2026 at 14:24, Peter Maydell <peter.maydell@linaro.org>
> > wrote:
> > >> On Thu, 29 Jan 2026 at 16:09, Peter Maydell <peter.maydell@linaro.org>
> > wrote:
> > >>> From: Nicolin Chen <nicolinc@nvidia.com>
> > >>>
> > >>> +    } else {
> > >>> +        config = STE_CONFIG(&ste);
> > >>> +
> > >>> +        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
> > >>> +            hwpt_id = accel->abort_hwpt_id;
> > >>> +        } else if (STE_CFG_BYPASS(config)) {
> > >>> +            hwpt_id = accel->bypass_hwpt_id;
> > >>> +        } else if (STE_CFG_S1_TRANSLATE(config)) {
> > >>> +            s1_hwpt = smmuv3_accel_dev_alloc_translate(accel_dev,
> > >>> + &ste, errp);
> > >> In this function we allocate memory and return it, assigning it to
> > >> s1_hwpt...
> > >>
> > >>
> > >>> +            if (!s1_hwpt) {
> > >>> +                return false;
> > >>> +            }
> > >>> +            hwpt_id = s1_hwpt->hwpt_id;
> > >>> +       }
> > >>> +    }
> > >>> +
> > >>> +    if (!hwpt_id) {
> > >>> +        error_setg(errp, "Invalid STE config for sid 0x%x",
> > >>> +                   smmu_get_sid(&accel_dev->sdev));
> > >>> +        return false;
> > >> ...but in this error-exit code path we don't free it.
> > s1_hwpt is allocated if iommufd_backend_alloc_hwpt() succeeded and if it did
> > hwpt_id cannot be NULL I think.
> > Shameer, Nicolin, please could you confirm
> >
> > Adding Shameer in TO
>
> Yes. If s1_hwpt is allocated, hwpt_id cannot be 0.
>
> s1_hwpt is only returned after iommufd_backend_alloc_hwpt() succeeds
> and provides a valid hwpt_id, which we assign to hwpt_id immediately
> after. So the later "!hwpt_id" error path cannot be hit in that case.

Thanks for confirming. I'll mark the coverity issue as a false positive.

-- PMM

