Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AFCD34082
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkl5d-0006sa-86; Tue, 27 Jan 2026 10:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vkl5Z-0006qd-QC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vkl5X-0000tT-Oa
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769528081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+h/xeHx3zq+tYCayALJUIBKHw9jpZUo3+hHA5tJU44=;
 b=JDC3SbuDNlXY3jF03iS5YtwEFva4NRQx1hxsqm7jbS9EEVdOHnblq5v41aczisSvUQn1wH
 +TvUbI4M4JK8KhPnrW+jrEEhaKiLxq0SbJ9kQyY0VjX03BH1aHpWQ0u8Mp/vgK16WiwlkV
 oEdg6f1qfZq6IZRx/JZFuAM5eXMv5xc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-l2oO0MFVMoWFYEeYXA6AXA-1; Tue, 27 Jan 2026 10:34:40 -0500
X-MC-Unique: l2oO0MFVMoWFYEeYXA6AXA-1
X-Mimecast-MFC-AGG-ID: l2oO0MFVMoWFYEeYXA6AXA_1769528079
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432db1a9589so4331938f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 07:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769528079; x=1770132879; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B+h/xeHx3zq+tYCayALJUIBKHw9jpZUo3+hHA5tJU44=;
 b=XSsb06oDaOqXEIhDRa2u31pwnIR7pS4k7Eao70E1n8tqhb1Yk7uffVhKMbrhUt1uwG
 vhMgFLJWPrArNsbUY0IEaxeLMKotHEjny+eDqU5jfkx5W/GVixmTUGjulGjwqjwphEXP
 ucjnHpAgCYU3MDZZsoH5pOd+nJwaZq3gVzFXLIcJ8f77ZZSs7UjbnIqoTk5KZg0OC+Qv
 7tpm+hNJqn6fB2l3L8bwTn7963Q7FfRG+dPX1nuTvy5qT8xjHakPd5tLKwwrPzLdZQUR
 TRcaAPzajQuVf5xR1VYVwqTczcl5WA6OelGkeN8/Aw1vLfsmMA2Mn95G0zxkaDNBRlAX
 vzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769528079; x=1770132879;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B+h/xeHx3zq+tYCayALJUIBKHw9jpZUo3+hHA5tJU44=;
 b=pobA185pOLt5+ISUwMqhaKvS2Z8CpMn7Jyxp9nBy6MjZUBFQnWf9VCd5tL9Ts/fwLl
 JxCTAANTlgLNIMP6U+EFVIXaRDX6GRZCId5epBoWQ67J9uRBn4/UxFMdW8F5MoNS/Wo6
 w89CqIY7Anh/P+TwAh+AV2RsAAcsrVhRDQt67baKTFvrjHC/0VJWDMs7T0wWJkauTtG8
 RYkh6Gb1ZyiHWhaV6aH+7EN44TKYlmIFEwL/sW4rLMmoYaZlg+JPXZbzQxVM8rz+JlKw
 NJEXmTVU4D6pqhQ26O6EMMeEiPbtd5mZLb1lqhzyCbprhv96RwIwfd5HDT56bXEE5oLs
 P73Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWSU1zwA77PjhpHW1KwRZZ0jNaBmxLhPIqCakj5TcwklacFr3w/4Fqy8qWCpdzv6ETEIIemCQOhEIo@nongnu.org
X-Gm-Message-State: AOJu0YxSqu778JYH7sVFsbt3RaCmAfNI56QstVIk0WuuQ/I7aYXVQcQK
 X/kLSR9JzI/XA6tz930RZBsMBaGZBuNTIVET/rNFQCi7Kpp4wFW/0O4OjIIEJiFnumFTY4wHr7F
 bpUlcdw3qbgGUi73jJXhz1mu6u/3UIXFiZBgUv2G1AVjFWPgbowvAXCts
X-Gm-Gg: AZuq6aKpAOSwgbV5v9kWH5hlAuPaOsQ5FixzqFnbpIQrQTerv4b7/oZNcxuf+Llpb9l
 OKzm0ifxFgxlkYEWuI9KnSf7bKcl9Va4EI2fDM+CGv13ReaXYJ+m5LY+Rt/x9QJcCDINwNjuCaH
 kLCEj1FFh599PBaxQfDDks5kuCwRCGHyls9bDjSZpnbgWKchVpp5Sws1l4VUUZaFx8BC1w/hf+o
 TRyttLzXQBfjVXmViNClmABH/vYhp/QJ1iVWtJKg/XnzvUZX1xt65I4DHccVXCuM0FEfp/HfNfy
 MC8PiysR7bKiYZUi4FTGQVQ2h2k5FRxN0qEVEi8cnej/XvpJpPkAHjLj2830mUSpQNreF7rJhlg
 YTV1y4GDpKaxZo7rqWkxYemzc3I2blGsWNXVz
X-Received: by 2002:a05:6000:248a:b0:435:db94:d81f with SMTP id
 ffacd0b85a97d-435dd1c3c72mr3201134f8f.47.1769528078666; 
 Tue, 27 Jan 2026 07:34:38 -0800 (PST)
X-Received: by 2002:a05:6000:248a:b0:435:db94:d81f with SMTP id
 ffacd0b85a97d-435dd1c3c72mr3201080f8f.47.1769528078101; 
 Tue, 27 Jan 2026 07:34:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02f71sm38879847f8f.6.2026.01.27.07.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 07:34:37 -0800 (PST)
Date: Tue, 27 Jan 2026 10:34:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v17 03/21] hw: arm: virt: rework MSI-X configuration
Message-ID: <20260127102534-mutt-send-email-mst@kernel.org>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-4-mohamed@unpredictable.fr>
 <CAFEAcA-GL9UG5MN5tKDzLwQ04cBGa99cSau4=2BLTs0+GGSdJw@mail.gmail.com>
 <51E78FA9-2C66-4E8E-947F-F009A8AEEDFD@unpredictable.fr>
 <CAFEAcA_7o-dNFUgMo=UdYD_cf=dwbMCy6b+_2SRSxVbDmmAUmw@mail.gmail.com>
 <9ECB5E0B-3BD3-47D3-9E6B-204A354CEA84@unpredictable.fr>
 <CAFEAcA_g3VfRectVpUG-OnLh_AtsqpLt7YYrYXDSfiesS5EuKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_g3VfRectVpUG-OnLh_AtsqpLt7YYrYXDSfiesS5EuKw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 27, 2026 at 02:10:08PM +0000, Peter Maydell wrote:
> On Tue, 27 Jan 2026 at 13:40, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> >
> >
> >
> > > On 27. Jan 2026, at 13:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 27 Jan 2026 at 12:46, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> > >>> On 27. Jan 2026, at 11:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >>>
> > >>> On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> > >>>> +/*
> > >>>> + * In the prior Qemu ACPI table handling, GICv2 configurations
> > >>>> + * had vms->its=1... That's broken.
> > >>>> + *
> > >>>> + * Match that assumption to match the existing ACPI tables that
> > >>>> + * have been shipping for quite a while.
> > >>>> + */
> > >>>> +static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {
> > >>>> +    return vms->gic_version == 2;
> > >>>> +}
> > >>>
> > >>> We don't need to keep identical bug-for-bug ACPI tables like that.
> > >>> If we were incorrectly reporting an ITS in a GICv2-only ACPI table,
> > >>> that was a bug and we can fix it. (This might need adjusting of the
> > >>> golden reference ACPI data in some of the bios-tables-tests if we
> > >>> were testing that, so it ought to go in its own patch.)
> > >>>
> > >> Hello,
> > >>
> > >> I’m a bit concerned about breaking hibernation in this case…
> > >>
> > >> My intent was keeping this behavior for now and then add a machine model version dependent toggle in a follow-up patch.
> > >
> > > I'm not an ACPI table expert but my understanding is that it's
> > > OK to change the ACPI table contents without having to make
> > > those changes machine-version dependent. See e.g. commit d6afe18b7242,
> > > which changed the ACPI tables for the its=off case and did not
> > > make those changes machine-version specific.
> 
> > That commit didn’t affect the default/regular config so it wouldn't have been too problematic in practice.
> >
> > Have had countless issues with how brittle hibernation is* - and more or less subtle ACPI table changes
> > tend to break it.
> 
> I don't want to add back-compat handling for this to the virt
> board unless one of our ACPI table experts says that yes we
> do need to keep the ACPI table contents identical for older
> versioned machine types.
> 
> thanks
> -- PMM


Generally what we have handles VM migration, not hybernation.  The issue
with hybernation is guests might cache some data to speed up init. If
you want to go overboard you would have to never change anything at all
in the firmware.  Whether they do it in any specific instance is hard to
predict 100% but our approach generally is to try with a couple of
popular guests, and not to worry too much ahead of time otherwise.  For
several reasons: one is most changes are harmless, another one there's
no special race here, if there's an issue you can trigger it
predictably, yet another one is hybernation is a rarely used feature.

For the specific change, I'd guess just test and if fine - fix it without a compat.

-- 
MST


