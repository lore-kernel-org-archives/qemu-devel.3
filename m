Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5303E67A62
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxR9Q-0003HL-CC; Tue, 03 Mar 2026 09:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxR97-0003Gx-Fl
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:54:49 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxR95-0005oh-6U
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:54:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772549664; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KUWdS+uFT9oggfDK/ruVFOBKSmHK69krmnC0AK1DxMNrotqp9kIbBfv2PbdO84ytB0vDacw+XzToNdHGQLRLShitaHn9bVtKODfk+0ioscWf3gQYzHZxZLfmRd0W+dM35nvO+yqxFzZM5BrUIUoo6UtBlDBCfwtmvVG7t0UUjSo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772549664;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2nhhNmH0bG7yoVypLO137OqbOkM9cTdwHmGLUd8+l2A=; 
 b=lgArkbQsD6IFVraXwpcHrz2GU+Yd5SZHOATIBPrKG3dVyHplzXsyhontxE+XfRdfFsMXvN3f++Zf+ka7SjWoVFjTWb3oPsgfh+TtU0smq2fAUTUIUkBgCKNnv+hROOrWl7W+jfsqPLKrwjkX5cxuspbzAJZb0jGI701vPDx36Kc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772549664; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2nhhNmH0bG7yoVypLO137OqbOkM9cTdwHmGLUd8+l2A=;
 b=HzIqBwqKIx/WcBkMUcMDIapv1jyDCzd8IA5G+Jhw8LNg73yEw0G/zi46kKCtMVej
 3BlzF3rx7iJtDkIj7uYQhUp5yigDz2pIIteuqcCDVez3lkGFsRmZ8JSmRfSiD9l/95e
 6kY8Ly2ARR43Wb+qvJ4omoFCs2eJV8QSPDTfdqKc=
Received: by mx.zohomail.com with SMTPS id 1772549662512827.9715536451264;
 Tue, 3 Mar 2026 06:54:22 -0800 (PST)
Message-ID: <b9192dfb-d4e5-4bc8-8dd8-14097f64a9d7@collabora.com>
Date: Tue, 3 Mar 2026 17:54:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 04/18] ui/gdk: Restore original context after new
 context creation
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
 <20260302145920.735423-5-dmitry.osipenko@collabora.com>
 <CAJ+F1C+KL2dAYGurXAk3Fc6TLNRa=FQU6U2=UqRkdeBw1uQRbw@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAJ+F1C+KL2dAYGurXAk3Fc6TLNRa=FQU6U2=UqRkdeBw1uQRbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/3/26 13:03, Marc-André Lureau wrote:
> On Mon, Mar 2, 2026 at 4:04 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Get currently bound GL context when creating new GL context and restore
>> it after the creation for consistency with behavior expected by virglrenderer
>> that assumes context-creation doesn't switch context.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Thanks for the review

-- 
Best regards,
Dmitry

