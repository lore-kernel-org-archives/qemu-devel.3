Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E84F54ACE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53w5-0002s2-Vg; Tue, 24 Mar 2026 11:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53w3-0002pZ-VY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:44:52 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53w2-0003V7-GJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:44:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-666f646f5cfso9349028a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367089; cv=none;
 d=google.com; s=arc-20240605;
 b=QGryv3gD04ktn6SxzFWDNIIDy/aHyn18+J/S7m95n83eOxPp909SzqLWMBY7qK/s6h
 a9VV3JncT7PaTvYk2Ec/plBF5iinyDrw1QXfqA7HDCYBAdDYL1KW8hfk4Lm4W30gVAj6
 FIXOebMgG0oDQMfbkOCtnQebOg10sVgIiF5OzirWt3AKe7zuoUGOyQLSfJYJNEYNRIWB
 qKikI+kdk8tf/N3HnYJqt6OBC+9jYJbPTX2OzXxFuWzAf7mNIYhCf5mme1rppAbaK798
 734XbDZuAx5LxtVE5ztrwIup0PG4v3vVpwiQN44L8Aohjxil4VAFxcC04UymPIRLPo8S
 6cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dycVPoOMlmKnE9sM91De/wxYtcazs1IWrTyzEg3/slE=;
 fh=6RY1YYZakaERMi8/DkhvkUeqhJnfOV6lGiakfBhpSxg=;
 b=XIXMAk6J71CXLLpRVwpWUkP0tJPs7fT3WfMIl6z6BLqBy9nvCdbRp4sWmAIJMuSIvN
 lTKRpeChb5i/S/tIXazcV/zLM3+EEMpx7yu9e3gIwwWCO7Ewdl1v542z2AS/gmr50Pe5
 UgT/kcIKkJLpwtmPSb2pMw2fHw06EtpkM9a0ZTwwidGqZjhMXsZcQaREXVz9LeMnQWU3
 yMFUI1wnr+xW2AS4iNV7wM6m3TllwGiny5RHm6ID/Pmn0H4Iroq4aGHyPRhS8z/RDioR
 OwMh+qINkERGE2Ww4IiTVQiEyc75ySXBKq9ltp9R4DCu+d9YNYaIcor+IcFXQ2gM5jYW
 8uTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774367089; x=1774971889; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dycVPoOMlmKnE9sM91De/wxYtcazs1IWrTyzEg3/slE=;
 b=Ok8pTb4tAtCZ7PUJOHCGc+a/UpuFCKntYYW3FfVqjvnX16sbVHVwFtynscOA5Q/t0K
 ObpGE9+m3KnQHQ+GU2vrnxsvu6ngdyohIa/49KZRHP4dGqimC+IAW8mi8Lszbh3IJAZn
 oNkjHBa08JNteTsKTkLBeUDthNz9QoGxXBz/xI1dk2hBda/N1J1dnROKoiCaaxjvna5z
 UFytdJBLnZaN9au9I3a50T/A+SS7b8coiNyG6Qas3upBuE4RCSu2OMlSJsxex018jaWN
 9Vc1xoaXmn+Pp3mvru6W53LX0dv/3m3roArprTZLu8qmR+XAQjSWIrPZ6hql6ZeCIEYE
 qnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774367089; x=1774971889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dycVPoOMlmKnE9sM91De/wxYtcazs1IWrTyzEg3/slE=;
 b=Yl4U4J58SOGddqAGmhv0Qipi9Q5X7gsB8LDhA1ldbJqDzCeoedXeP/d49cFweJd7cr
 BhyVnGbiAEXmLA+giFjqDKHUET67qhlx448IMn+xG5/d4oMj7vhjlyV6yyBoO/j3tWjL
 5uB5sgxqtWCg855/P0camTtIagcFyfnnHBot0jnXGSFSPcv/y+xjXlUL2zsuDuHKq2WT
 M5sn8RDf4jAsCBdALsi8mHCW4DQxokvp7WyEtZaU+tYQd4zKUvHugV4RnP3lQTsO9guj
 i3aY73G4XgqiVuMzJeFCBp1Jm5FWxR3t0KU2EMK5UMJzVJSRH6blBw2XKCTwud/AgP7G
 aKMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOP4WsI0XqKz47JwY2eAtyf3IV9ug+B6asKXl2WZ3WvhcZkA+vX1JAsHQmAhuKXCUlTfz1wVss42Td@nongnu.org
X-Gm-Message-State: AOJu0Ywp9ic177gA2YCaNcMM+0JfO6WoAKGItoismcx1HcgezT7YX4wK
 J4A3g9LwxgIpU/H7/kvVdwI8Ai9yYrlB4irrfE+ikviInZBAJBgEl9UOPRQA2y0m18xRx0KaNmF
 uRxsVMup05sDnD6y+qp9//Wuy4zczS22slSwRv1fTiA==
X-Gm-Gg: ATEYQzwsnqXdDb8Rz/hv/TD54kWzBlGXGXA9HHVplOg12+Jp22Qw/vD+OccOYwn4GmX
 NV/Zo5o5FYXH5RUzjzq4uPNh9H1GU8/tUBDgY/0ckRZvv1zUtqKqyDSVLYlymj1kREJ5APW2WyL
 SkiFZOSgo1WNM5UHq2eReQEZDEMkYjsNL+hMY2DJFRIQiG8rrFcSA+5RnEuT4J8c7qRfIY73T4W
 4ozxpfaY8zKkBH0peDFc5szPKxxE33x4ykotf2nJQsBBvH2bpb3XeVlfwHh/5QKU7RtqnCNPYKS
 BGNBgPk5NNFWM8QsjSbH+FUdW0P+qqo1BtrD2hSLbs04vgEBxDe5oFpA31clCO5N/bY=
X-Received: by 2002:a17:907:3f8d:b0:b96:e1de:db04 with SMTP id
 a640c23a62f3a-b98864026d5mr238285866b.18.1774367088624; Tue, 24 Mar 2026
 08:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-60-48eb1dcf7b76@redhat.com>
 <acKsobCZ2G8TE2XI@redhat.com>
In-Reply-To: <acKsobCZ2G8TE2XI@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 15:44:34 +0000
X-Gm-Features: AQROBzC7G5HRO1XZHcQr60e0IgZ_c-BA7OwsJUdWRFVW9638EGtleBkNjKyY_w0
Message-ID: <CAFEAcA9wBuHxmYp5wdZ0HOtUhTqmWfUJaZuLxrUbz=m4h+mA-A@mail.gmail.com>
Subject: Re: [PATCH 60/60] contrib/qemu-vnc: add standalone VNC server over
 D-Bus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 24 Mar 2026 at 15:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> IMHO we should not really be adding more things to the contrib
> directory, and rather wish most of the existing stuff was
> not there. When I see "contrib" directories in projects, the
> message is generally "unmaintained, abandoned junk".

Definitely agreed: either we care about something, and it should
have a proper place and somebody who maintains it; or else
we don't care about it and should kick it out of the tree.
Having a contrib/ directory is an attractive nuisance for
accumulating more stuff in the awkward halfway-house.

We should really clean up the existing /contrib/ and move
stuff into where it belongs (quite often tools/, which in
turn mostly contains things that should *not* be in tools/...)

-- PMM

