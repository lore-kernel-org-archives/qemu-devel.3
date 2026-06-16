Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CB2CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZavg-0000RZ-Qs; Tue, 16 Jun 2026 17:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZavb-0000Q1-Va
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZava-0001UZ-Bh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781643752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZrS83FVDh7XcjY93fZM/uw3X5ANblCtiBBhJb1FQR4=;
 b=SKOq7Rb4ooCkcBLEG0MeIccxmp2rkfXv+q/WK0GEDFfFMp/QbAIz4gmj/2oFm7q2ERSeuE
 OWwwnoqxNms3fD4oIeG60NiLkcyhaklU+qm8b72+NXikHmHkE+YVlcx5CEMqBQcPcya0Qu
 Hftk3LK0hEtZixURjZXtCIRaMPjtOXo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-5CuQ1UaFM8-mttiUW4ExiQ-1; Tue, 16 Jun 2026 17:02:30 -0400
X-MC-Unique: 5CuQ1UaFM8-mttiUW4ExiQ-1
X-Mimecast-MFC-AGG-ID: 5CuQ1UaFM8-mttiUW4ExiQ_1781643750
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7fccd214113so21569677b3.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781643750; x=1782248550; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KZrS83FVDh7XcjY93fZM/uw3X5ANblCtiBBhJb1FQR4=;
 b=FExgtE1QeM4WVvvFkAxdkVY6UVHYEMhQ56sT8IM3E2kReFAN2CWdpmLdTThAuVc9Jo
 GbRwkdYMPM61QFEB+CPQlX4ifNjxHSsNhXmFzaW57Mx9kf+0O/Qycf1Y44Yw050gcgXM
 P6OX6roJ9SiiM2JfhG3L2LTXmnv3X3397JsX1FrfgMFaHHZhHvX1aa/1zHMhfXfPh951
 zAkZixbksaHfTn3nDpyUw6Pfi7P0AfRQrsgSOcz022OrC8O/424n3VyQxar6gGIiGwaX
 Qx0QsiB/oPBexOIY8iQznfJGJn41TCpANzyzb3l2DtqkiQ3iW3+VNJBeutDQGS73juh/
 E5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643750; x=1782248550;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KZrS83FVDh7XcjY93fZM/uw3X5ANblCtiBBhJb1FQR4=;
 b=kAT+uyEhJWSRVaoF3XVnyERuPdXsR9R+14fuhFfZCaoA84eTc2awfcLJapcV+aRuP4
 iiklOmJnRs9s9fsQXld5IoN/UzMqPQ3hDGkUH1+FB/jGJqV7fOFs109FTVMAcw8SfFSn
 weptKS1r9+QhEQidt7lx17RrL5YSAIsEW+43plt9Jr2HWJID6/Xqw5tPEOkf0k4Zm5Rf
 jmHHA+3+PfdfJKV2DmHcjh7OPjTRaDUo8xx71AHWesg5dCwEEdme7HtGVbKRTnoptvL2
 m5egU2p2L+DForu01ZrLF7BrTPqcBqE9FLqRq3HTRGzxcUjChXJwGNcs9SQ6bquV7l6p
 +TjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+K2evaZZbANiRRFAEWcPRTTYbVXxdwYG9JADPBoHabfPii059Kysq3c50bzkK5GIoqReg92UAc642s@nongnu.org
X-Gm-Message-State: AOJu0Yw7ONyJs692efptWFjvQVU5211o0Yok5+iIRsl6QR04ebIG4OAt
 2iQdQHL4jNfa0TBi28j2BX9zz+9YsEnc4fmpJ+JfX+7EkWFdDhTbJ8+LlkGndKNP9aZJ5ZUfqBo
 uTYF1xX+kgKotdhGpRypByOy7ReQ+J1TZWy6gMzrrDoi/CbJz/cTArV9t
X-Gm-Gg: AfdE7cmpAIGlP1SyXevBRRC+R3wj/L+0djF9ye6B16GHb2wOzIKUZnXRDVfuzz4AYZr
 v/BBsaTjx69WNj/KHw9uo+9rsxe6m5HkDob2K9/C/kpxlSzAy9hveY8fSHWFX7wK1e4+UWqrYmO
 HC3OBHqKzKoRnHKUfGOuykQbridE4rCcuo2FBf/6DJ7DtUEBL+A2WsCDuvhO2zJOmrNDRdvuFRd
 zdLp3AhwYTN7/5Nuw/QJZjPLoL36Eu/w87Uw8Cgpwa6zsAgtzrQZ5qSgQNIMxYOHocr0t1hagCw
 SE2Dv17qi7O9OaK/ae7ZnW4x/vRJgyZegh0eWn1tkPJJAdUkxiOzhWvo3miT66Exg1qC18/Vubt
 9H/4k0n8u/zoqVpE=
X-Received: by 2002:a05:690c:62c2:b0:7f0:182:b5d1 with SMTP id
 00721157ae682-7fe5d3ade68mr8873797b3.12.1781643750129; 
 Tue, 16 Jun 2026 14:02:30 -0700 (PDT)
X-Received: by 2002:a05:690c:62c2:b0:7f0:182:b5d1 with SMTP id
 00721157ae682-7fe5d3ade68mr8872957b3.12.1781643749479; 
 Tue, 16 Jun 2026 14:02:29 -0700 (PDT)
Received: from x1.local ([142.188.212.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f5b8e73csm43683496d6.49.2026.06.16.14.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:02:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:02:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
Message-ID: <ajG54jNEs4JDBRJP@x1.local>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com>
 <aimNv51iMZ_yEgDG@redhat.com> <aimvTYDsv_-Xsboy@x1.local>
 <aiq9g60bOnvsOQOy@redhat.com> <87h5n94001.fsf@suse.de>
 <airI3UKeVVRUdQHq@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <airI3UKeVVRUdQHq@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 03:40:29PM +0100, Daniel P. Berrangé wrote:
> There's nothing standard in QOM, but in patch 10 in this series
> Peter has a DEFINE_TLS_PROP_HELPERS() which macro-ized the
> repetitive getters/setters for the TLS string properties. The
> duplicate code still exists in the binary of course, just hidden
> from the source.

I believe we have the standard, which is qdev-properties.. which is (1)
class properties, (2) allow variable bindings so no setter/getter needed,
remembering them with pointer offsets.

It goes back to last version where the question becomes: whether we want to
make qdev-properties to be official QOM API, by removing qdev specific
changes and move them over to qom/.  Then make qdev only add its special
things on top.

Said that, considering if we want to make all things qom-set-able to
migration in the future, another option is directly go with getter/setter
that will do the property checks one by one. One benefit of that is we can
then get rid of migrate_params_check() and migrate_caps_check() altogether.

Maybe I should go with the latter, and forget qdev?

Thanks,

-- 
Peter Xu


